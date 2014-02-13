class CreateNotificacoes < ActiveRecord::Migration
  def change
    create_table :notificacoes do |t|
      t.references :arquivo, index: true
      t.references :versao, index: true
      t.references :comentario, index: true
      t.references :usuario, index: true
      t.string :texto
      t.boolean :lido

      t.timestamps
    end
  end
end
