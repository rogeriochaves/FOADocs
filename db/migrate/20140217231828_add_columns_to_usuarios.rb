class AddColumnsToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :provider, :string
    add_column :usuarios, :uid, :string
  end
end
