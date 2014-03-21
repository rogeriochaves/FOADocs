class AddRefreshTokenToUsuarios < ActiveRecord::Migration
  def change
  	remove_column :usuarios, :cloud_token, :string
    add_column :usuarios, :refresh_token, :string
  end
end
