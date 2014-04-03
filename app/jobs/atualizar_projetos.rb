class AtualizarProjetos
  include SuckerPunch::Job

  def perform(projeto)
  	ActiveRecord::Base.connection_pool.with_connection do
      projeto.update_changes
    end
  end
end