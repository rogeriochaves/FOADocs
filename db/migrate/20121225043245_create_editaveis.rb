class CreateEditaveis < ActiveRecord::Migration
  def change
    create_table :editaveis do |t|
      t.string :chave
      t.text :texto
      t.attachment :foto

      t.timestamps
    end
  end
end
