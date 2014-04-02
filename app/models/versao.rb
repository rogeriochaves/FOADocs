class Versao < ActiveRecord::Base
  	belongs_to :arquivo

	def create_with_item(usuario, item)
		self.modified_date = item.modified_date
		self.download_url = self.arquivo.download_url

		if self.arquivo.tamanho <= 3.megabyte and self.arquivo.mime_type.match(/(application\/msword|text\/plain|application\/vnd\.openxmlformats-officedocument\.wordprocessingml\.document)/)
			file_contents = usuario.google_drive.baixa_arquivo(item)
			if self.arquivo.mime_type.match(/(application\/msword|application\/vnd\.openxmlformats-officedocument\.wordprocessingml\.document)/)
				file_contents = Yomu.read :text, file_contents
			end
			if file_contents
				self.conteudo = file_contents
				if ultima_versao = self.arquivo.versoes.last
					diff = Diffy::Diff.new(
						ultima_versao.conteudo.force_encoding("UTF-8"),
						conteudo.force_encoding("UTF-8"),
						:include_plus_and_minus_in_html => true,
						:context => 1
					).to_s(:html_simple)
					self.alteracao = diff
				end
			end
		end

		self.last_modifying_user_name = item.last_modifying_user_name
		self.tamanho = self.arquivo.tamanho
	end

	def mudanca
		if self.arquivo.versoes.first.id == self.id
			"criado"
		else
			"alterado"
		end
	end
end