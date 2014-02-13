class CreateArquivos < ActiveRecord::Migration
  def change
    create_table :arquivos do |t|
      t.references :projeto, index: true
      t.references :arquivo, index: true
      t.string :file_id
      t.string :nome
      t.boolean :diretorio
      t.string :mime_type
      t.string :etag
      t.integer :tamanho, :limit => 8
      t.string :download_url
      t.string :icon_link

      t.timestamps
    end
  end
end
