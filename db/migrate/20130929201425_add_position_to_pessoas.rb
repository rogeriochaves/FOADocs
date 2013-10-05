class AddPositionToPessoas < ActiveRecord::Migration
  def change
    add_column :pessoas, :position, :integer, :default => 999
  end
end