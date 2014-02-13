class CreateVersoes < ActiveRecord::Migration
  def change
    create_table :versoes do |t|
      t.references :arquivo, index: true
      t.string :revision_id
      t.string :download_url
      t.text :conteudo
      t.text :alteracao
      t.datetime :modified_date
      t.string :last_modifying_user_name
      t.integer :tamanho, :limit => 8

      t.timestamps
    end
  end
end
