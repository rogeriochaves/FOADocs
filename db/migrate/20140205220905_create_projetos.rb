class CreateProjetos < ActiveRecord::Migration
  def change
    create_table :projetos do |t|
      t.string :nome
      t.string :tipo
      t.datetime :data_inicio
      t.boolean :fechado

      t.timestamps
    end
  end
end
