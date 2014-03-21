class AddTokenToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :token, :string
  end
end
