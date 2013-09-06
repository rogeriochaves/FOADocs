class CreatePaginas < ActiveRecord::Migration
  def change
    create_table :paginas do |t|
      t.string :url
      t.string :title
      t.string :description
      t.text :metatags

      t.timestamps
    end
  end
end
