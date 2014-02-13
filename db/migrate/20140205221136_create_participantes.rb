class CreateParticipantes < ActiveRecord::Migration
  def change
    create_table :participantes do |t|
      t.references :usuario, index: true
      t.references :projeto, index: true
      t.string :grupo

      t.timestamps
    end
  end
end
