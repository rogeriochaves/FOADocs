class AtualizarProjetos
  include SuckerPunch::Job

  def perform
  	ActiveRecord::Base.connection_pool.with_connection do
  		Projeto.all.each do |projeto|
	  		usuario = projeto.get_admin
	  		root = projeto.create_or_find_project_root_folder
        puts "Atualizando projeto #{projeto.nome}"
	  		AtualizarArquivos.new.perform(usuario, projeto, root.id)
	  	end
    end
  end
end