class AddPositionToBanneres < ActiveRecord::Migration
  def change
    add_column :banneres, :position, :integer, :default => 999
  end
end