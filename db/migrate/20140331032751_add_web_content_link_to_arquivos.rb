class AddWebContentLinkToArquivos < ActiveRecord::Migration
  def change
    add_column :arquivos, :web_content_link, :string
  end
end
