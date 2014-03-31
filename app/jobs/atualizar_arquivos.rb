class AtualizarArquivos
  include SuckerPunch::Job

  def perform(projeto)
  	ActiveRecord::Base.connection_pool.with_connection do
  		usuario = projeto.get_admin
  		root = projeto.create_or_find_project_root_folder
    	puts root.inspect
    end
  end
end