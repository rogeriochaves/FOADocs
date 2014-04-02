class Projeto < ActiveRecord::Base
	has_many :participantes
	has_many :usuarios, :through => :participantes
	has_many :arquivos, :dependent => :destroy
	has_many :versoes, :through => :arquivos
	validates_presence_of :nome
	after_create :create_or_find_project_root_folder

	def to_s
		self.nome
	end

	def get_admin
		self.participantes.where(grupo: "admin").first.usuario
	end

	def create_or_find_project_root_folder(usuario = nil)
		usuario ||= get_admin
		if f = find_root_folder(usuario)
			return f
		else
			google_drive = usuario.google_drive
			google_drive.cria_pasta(self.nome)
			return find_root_folder(usuario)
		end
	end

	def find_root_folder(usuario)
		google_drive = usuario.google_drive
		pastas = google_drive.lista_arquivos(nil)
		pastas.items.each do |item|
			return item if item.title == self.nome
		end
		return nil
		#google_drive.cria_pasta(self.nome)
	end
end
