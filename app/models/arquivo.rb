class Arquivo < ActiveRecord::Base
	belongs_to :projeto
	belongs_to :arquivo
	has_many :versoes, :dependent => :destroy, :order => :id
	validates_presence_of :file_id, :nome, :projeto

	def to_s
		self.nome
	end

	def self.update_or_create_arquivo(usuario, projeto, item) # item = json do google drive
		arquivo = Arquivo.where(projeto_id: projeto.id).where("file_id = ? OR etag = ?", item.id, item.etag).first
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
		arquivo.trashed = item.labels.trashed

		last_version = arquivo.versoes.last
		if arquivo.new_record? or !last_version or last_version.modified_date != item.modified_date or last_version.trashed != arquivo.trashed
			versao = Versao.new(arquivo: arquivo)
			versao.create_with_item(usuario, item)
		end
		
		arquivo.save
		versao.save if versao
		return arquivo
	end

	def icone
		extensoes = %w(ac3 ace ade adp ai aiff ani asf au avi bat bin bmp bsp bup cab cal cat css cue cur daa dat dcr der dic divx diz dll doc docx dvd dwg dwt fon gam gif hlp hst html ico ifo inf ini iso java jif jpeg jpg log m4a mdl mid mmf mmm mov mp2 mp2v mp3 mp4 mpeg msp nfo pdf php png ppt pptx psd ra rar reg rtf spr theme tiff tlb torrent ttf txt url vob vtf wad wav wma wmv wpl wri xls xlsx xml xps xsl zip)
		extensao = self.nome.split(".")[-1]
		if extensoes.include? extensao
			return "icons/#{extensao}.png"
		else
			return "icons/file.png"
		end
	end
end
