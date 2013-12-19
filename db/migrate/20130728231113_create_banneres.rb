class CreateBanneres < ActiveRecord::Migration
  def change
    create_table :banneres do |t|
      t.string :nome
      t.string :link
      t.attachment :foto

      t.timestamps
    end
  end
end
