class CreateMensagens < ActiveRecord::Migration
  def change
    create_table :mensagens do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :mensagem

      t.timestamps
    end
  end
end
