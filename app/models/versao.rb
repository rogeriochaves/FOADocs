# encoding: utf-8
#require 'iconv'
class Versao < ActiveRecord::Base
  	belongs_to :arquivo
  	has_many :comentarios, order: :id
  	after_create :gerar_notificacao

	def gerar_notificacao
	  	Notificacao.create_with_versao(self)
	end

	def create_with_item(usuario, item)
		self.modified_date = item.modified_date
		self.download_url = self.arquivo.download_url
		self.nome = self.arquivo.nome
		self.trashed = self.arquivo.trashed

		if !self.arquivo.diretorio and self.arquivo.tamanho and self.arquivo.tamanho <= 3.megabyte and self.arquivo.mime_type.match(/(application\/msword|text\/plain|application\/vnd\.openxmlformats-officedocument\.wordprocessingml\.document)/)
			file_contents = usuario.google_drive.baixa_arquivo(item)
			if self.arquivo.mime_type.match(/(application\/msword|application\/vnd\.openxmlformats-officedocument\.wordprocessingml\.document)/)
				file_contents = Yomu.read :text, file_contents
			end
			if file_contents
				ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
				self.conteudo = ic.iconv(file_contents)
				if ultima_versao = self.arquivo.versoes.last
					diff = Diffy::Diff.new(
						ultima_versao.conteudo,
						conteudo,
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
		if self.trashed
			self.arquivo.diretorio ? "excluída" : "excluído"
		elsif !self.arquivo.versoes.first or self.arquivo.versoes.first.id == self.id
			self.arquivo.diretorio ? "criada" : "criado"
		else
			if versao_anterior and versao_anterior.trashed
				self.arquivo.diretorio ? "restaurada" : "restaurado"
			elsif versao_anterior and versao_anterior.nome != self.nome
				if self.arquivo.diretorio or versao_anterior.tamanho == self.tamanho
					self.arquivo.diretorio ? "renomeada" : "renomeado"
				else
					"renomeado e alterado"
				end
			else
				self.arquivo.diretorio ? "alterada" : "alterado"
			end
		end
	end

	def versao_anterior
		return @versao_anterior if @versao_anterior
		anterior = nil
		self.arquivo.versoes.each do |versao|
			if versao.id == self.id
				@versao_anterior = anterior
				return anterior
			else
				anterior = versao
			end
		end
		@versao_anterior = anterior
		return anterior
	end

	def deve_aparecer?
		if self.trashed and (!versao_anterior or versao_anterior.trashed)
			return false
		end
		return true
	end
end