class AddPositionToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :position, :integer, :default => 999
  end
end