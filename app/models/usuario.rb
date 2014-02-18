# encoding: UTF-8
class Usuario < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,#, :registerable,
         :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  validates_presence_of :nome, :grupo, :email, :message => "não pode ser vazio"
  validates_format_of :email, :with => /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})([a-z ])?\z/i, :message => "é inválido"
  validates_confirmation_of :password, :message => 'confirmação incorreta'
  
  def password=(password)
    super(nil) if !password or password.empty?
    super
  end

  def admin?
    self.grupo == 'admin'
  end

  def self.find_for_google_oauth2(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.nome = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
    end
  end

end