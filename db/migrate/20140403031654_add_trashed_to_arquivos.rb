class AddTrashedToArquivos < ActiveRecord::Migration
  def change
    add_column :arquivos, :trashed, :boolean
  end
end
