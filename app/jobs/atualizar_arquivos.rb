class AtualizarArquivos
  include SuckerPunch::Job

  def perform(usuario, projeto, file_id)
  	ActiveRecord::Base.connection_pool.with_connection do
  		usuario.lista_arquivos(file_id).items.each do |item|
  			if arquivo = Arquivo.update_or_create_arquivo(usuario, projeto, item) and arquivo.diretorio
          puts "Atualizando pasta #{arquivo.nome}"
  				AtualizarArquivos.new.perform(usuario, projeto, arquivo.file_id)
  			end
  		end
    end
  end

end