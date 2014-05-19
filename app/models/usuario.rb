# encoding: UTF-8
class Usuario < ActiveRecord::Base

    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable,#, :registerable,
         :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

    validates_presence_of :nome, :grupo, :email, :message => "não pode ser vazio"
    validates_format_of :email, :with => /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})([a-z ])?\z/i, :message => "é inválido"
    validates_confirmation_of :password, :message => 'confirmação incorreta'
    has_many :participantes
    has_many :notificacoes
    has_many :projetos, :through => :participantes
  
    def password=(password)
        super(nil) if !password or password.empty?
        super
    end

    def notificacoes_de_comentarios
        Notificacao.where(usuario: self).where("comentario_id IS NOT NULL")
    end

    def notificacoes_de_arquivos
        Notificacao.where(usuario: self).where("arquivo_id IS NOT NULL OR versao_id IS NOT NULL")
    end

    def notificacoes_de_comentarios_nao_lidas
        notificacoes_de_comentarios.where(lido: false)
    end

    def notificacoes_de_arquivos_nao_lidas
        notificacoes_de_arquivos.where(lido: false)
    end

    def admin?
        self.grupo == 'admin'
    end

    def self.find_for_google_oauth2(current_usuario, auth)
        if user = Usuario.where(auth.slice(:provider, :uid)).first
          # ok
        else
          user = (current_usuario || Usuario.new)
        end
        user.provider = auth.provider
        user.uid = auth.uid
        #user.email = auth.info.email
        user.token = auth.credentials.token
        user.refresh_token = auth.credentials.refresh_token
        user.nome = auth.info.name
        user.image = auth.info.image
        user.save
        return user
    end

    def google_drive
        @google_drive ||= GoogleDrive.new(self)
    end

    def lista_arquivos(id = nil)
        google_drive.lista_arquivos(id)
    end

    def info_arquivo(id)
        google_drive.info_arquivo(id)
    end

end