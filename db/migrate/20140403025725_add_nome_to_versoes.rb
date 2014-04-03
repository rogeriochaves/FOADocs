class AddNomeToVersoes < ActiveRecord::Migration
  def change
    add_column :versoes, :nome, :string
  end
end
