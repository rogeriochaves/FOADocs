class Projeto < ActiveRecord::Base
	has_many :participantes
	has_many :usuarios, :through => :participantes
	has_many :arquivos, :dependent => :destroy
	has_many :versoes, :through => :arquivos, :order => "ID DESC"
	validates_presence_of :nome
	after_create :create_or_find_project_root_folder

	def to_s
		self.nome
	end

	def md5_key(email)
		Digest::MD5.hexdigest("#{self.id}#{email}v3n4nc10")
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

	def update_changes(usuario = nil, root = nil)
		usuario ||= get_admin
		if !root
			root = create_or_find_project_root_folder(usuario)
		end
		google_drive = usuario.google_drive
		changes = google_drive.get_changes_list(self.largest_change_id)
		prints = []
		changes.items.each do |item|
			if item.file and item.file.parents[0] and (item.file.parents[0].id == root.id or parent = Arquivo.where(projeto_id: self.id, file_id: item.file.parents[0].id).first)
				arquivo = Arquivo.update_or_create_arquivo(usuario, self, item.file)
			end
		end
		self.update(largest_change_id: changes.largest_change_id)
	end

	def share_folder(email, usuario = nil)
		usuario ||= get_admin
		google_drive = usuario.google_drive
		google_drive.share_folder(create_or_find_project_root_folder(usuario).id, email)
	end
end
