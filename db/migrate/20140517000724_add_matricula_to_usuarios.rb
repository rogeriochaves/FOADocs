class AddMatriculaToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :matricula, :string
  end
end
