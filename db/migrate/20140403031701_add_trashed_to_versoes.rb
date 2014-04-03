class AddTrashedToVersoes < ActiveRecord::Migration
  def change
    add_column :versoes, :trashed, :boolean
  end
end
