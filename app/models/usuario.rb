# encoding: UTF-8
class Usuario < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,#, :registerable,
         :rememberable, :trackable#, :validatable

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

end