class CreateEditables < ActiveRecord::Migration
  def change
    create_table :editables do |t|
      t.string :key
      t.text :text
      t.attachment :picture

      t.timestamps
    end
  end
end