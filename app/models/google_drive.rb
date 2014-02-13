require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'

class GoogleDrive
  CREDENTIALS_FILE = Rails.root.join('tmp', 'google_api_credentials.json')

  def initialize
    credentials_storage = ::Google::APIClient::FileStorage.new(CREDENTIALS_FILE)
    @client = ::Google::APIClient.new(
      application_name:    'MyApp',
      application_version: '1.0.0'
    )
    @client.authorization = credentials_storage.authorization || begin
      installed_app_flow = ::Google::APIClient::InstalledAppFlow.new(
        client_id:     '808107694640-kvtrshot11r1nf2cvle1c1drhf5qcnc4.apps.googleusercontent.com',
        client_secret: 'Mh1k3ppG230gJRQyfdLMhWi_',
        scope:         ['https://www.googleapis.com/auth/drive'],
        redirect_uri:  'http://localhost:3000/'
      )
      installed_app_flow.authorize(credentials_storage)
    end
    @drive = @client.discovered_api('drive', 'v2')
  end

  def download_latest_proxylist(search_period = 1.week.ago)
    result = @client.execute(
      api_method: @drive.files.list,
      parameters: {
        q: %(title contains "proxylist" and modifiedDate > "#{search_period.strftime('%Y-%m-%dT%H:%M:%S%z')}")
      }
    )
    file = result.data['items'].first
    download_url = file['downloadUrl']
    result = @client.execute(uri: download_url)
    output_file = Rails.root.join('tmp', file['originalFilename'])
    IO.binwrite output_file, result.body
    file['createdDate']
  end
end