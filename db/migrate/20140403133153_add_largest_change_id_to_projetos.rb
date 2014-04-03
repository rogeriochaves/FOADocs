class AddLargestChangeIdToProjetos < ActiveRecord::Migration
  def change
    add_column :projetos, :largest_change_id, :integer, :limit => 8
  end
end
