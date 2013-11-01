class AddPositionTo<%= @camel %> < ActiveRecord::Migration
  def change
    add_column :<%= @plural %>, :position, :integer, :default => 999
  end
end