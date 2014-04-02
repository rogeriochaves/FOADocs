class Arquivo < ActiveRecord::Base
	belongs_to :projeto
	belongs_to :arquivo
	has_many :versoes, :dependent => :destroy
	validates_presence_of :file_id, :nome, :projeto

	def to_s
		self.nome
	end

	def self.update_or_create_arquivo(usuario, projeto, item) # item = json do google drive
		arquivo = Arquivo.where(projeto_id: projeto.id, file_id: item.id).first
		arquivo = Arquivo.new if !arquivo
		arquivo.projeto = projeto
		arquivo.arquivo = Arquivo.where(file_id: item.parents[0].id).first
		arquivo.file_id = item.id
		arquivo.nome = item.title
		arquivo.diretorio = (item.mime_type == "application/vnd.google-apps.folder")
		arquivo.mime_type = item.mime_type
		arquivo.etag = item.etag
		arquivo.tamanho = item.file_size
		arquivo.download_url = (item.download_url ? item.download_url : item['exportLinks'] ? item['exportLinks']['text/plain'] : "") if !arquivo.diretorio
		arquivo.web_content_link = (item.web_content_link ? item.web_content_link : "https://drive.google.com/uc?id=#{item.id}")
		arquivo.icon_link = item.icon_link

		if arquivo.new_record? or !arquivo.versoes.last or arquivo.versoes.last.modified_date != item.modified_date
			versao = Versao.new(arquivo: arquivo)
			versao.create_with_item(usuario, item)
		end
		
		arquivo.save
		versao.save if versao
		return arquivo
	end
end
