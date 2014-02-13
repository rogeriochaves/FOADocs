class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.references :usuario, index: true
      t.references :versao, index: true
      t.text :comentario

      t.timestamps
    end
  end
end
