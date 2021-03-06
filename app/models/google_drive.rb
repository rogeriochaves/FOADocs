require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'

class GoogleDrive
  CLIENT_ID = '808107694640-kvtrshot11r1nf2cvle1c1drhf5qcnc4.apps.googleusercontent.com'
  CLIENT_SECRET = 'Mh1k3ppG230gJRQyfdLMhWi_'
  OAUTH_SCOPE = ['https://www.googleapis.com/auth/drive','https://www.googleapis.com/auth/userinfo.email','https://www.googleapis.com/auth/userinfo.profile']
  #REDIRECT_URI = (Rails.env == "production" ? 'http://foadocs.herokuapp.com/' : 'http://localhost:3000/')

  def initialize(usuario)
    @usuario = usuario
  end

  def lista_arquivos(id = nil)
    if id.nil?
      q = "mimeType='application/vnd.google-apps.folder' and 'root' in parents and trashed=false"
    else
      q = "'#{id}' in parents"
    end
    result = do_request do
      # pega as pastas da raíz
      api_client.execute(
        :api_method => drive.files.list,
        :authorization => user_credentials,
        :parameters => {
          'q' => q
        }
      )
    end
  end

  def info_arquivo(id)
    result = do_request do
      api_client.execute(
        :api_method => drive.files.get,
        :authorization => user_credentials,
        :parameters => {
          'fileId' => id
        }
      )
    end
  end

  def share_folder(id, email)
    new_permission = drive.permissions.insert.request_schema.new({
      'value' => email,
      'type' => "user",
      'role' => "writer"
    })

    result = do_request do
      api_client.execute(
        :api_method => drive.permissions.insert,
        :body_object => new_permission,
        :authorization => user_credentials,
        :parameters => {
          'fileId' => id
        }
      )
    end
  end

  def cria_pasta(nome)
    file = drive.files.insert.request_schema.new({
      'title' => nome,
      'mimeType' => 'application/vnd.google-apps.folder'
    })

    result = do_request do
      api_client.execute(
        :api_method => drive.files.insert,
        :body_object => file,
        :authorization => user_credentials
      )
    end
  end

  def get_changes_list(largest_change_id = nil)
    parameters = {
      'maxResults' => '500'
    }
    parameters['startChangeId'] = largest_change_id if largest_change_id

    result = do_request do
      api_client.execute(
        :api_method => drive.changes.list,
        :authorization => user_credentials,
        :parameters => parameters
      )
    end

    if result.next_page_token
      return get_changes_list(result.largest_change_id - 500)
    else
      return result
    end

    #raise result.inspect
  end

  def cria_arquivo
    file = drive.files.insert.request_schema.new({
      'title' => 'My document',
      'description' => 'A test document',
      'mimeType' => 'text/plain'
    })

    media = Google::APIClient::UploadIO.new('documento.txt', 'text/plain')

    result = do_request do
      api_client.execute(
        :api_method => drive.files.insert,
        :body_object => file,
        :media => media,
        :parameters => {
          'uploadType' => 'multipart',
          'alt' => 'json'},
        :authorization => user_credentials
      )
    end
    raise result.inspect
  end

  def baixa_arquivo(item)
    if item.download_url
      result = do_request do
        api_client.execute(:uri => item.download_url, :authorization => user_credentials)
      end
      return result
    else
      # The file doesn't have any content stored on Drive.
      return nil
    end
  end

  def delete_arquivo(file_id)
    result = do_request do
      api_client.execute(
        :api_method => drive.files.delete,
        :parameters => { 'fileId' => file_id },
        :authorization => user_credentials
      )
    end
  end

  private

  def api_client
    @client ||= begin
      client = Google::APIClient.new(application_name: 'MyApp', application_version: '1.0.0')
      client.authorization.client_id = CLIENT_ID
      client.authorization.client_secret = CLIENT_SECRET
      client.authorization.scope = OAUTH_SCOPE
      client
    end
  end

  def auth
    @auth ||= api_client.authorization.dup
  end

  def drive
    @drive ||= api_client.discovered_api('drive', 'v2')
  end

  def do_request(&block)
    if auth.expired?
      refresh_token
    end

    res = yield
    case res.status
    when 200, 201, 202, 204 # success
      res.data || res.body
    when 400
      raise BadRequestError, res
    when 401
      if !@retrying
        @retrying = true
        refresh_token
        do_request(&block) # retry the request
      else
        raise "Already attempted retry. Auth token=#{auth.access_token} is invalid."
      end
    when 404
      raise ResourceNotFoundError, res
    when 500
      raise UnexpectedAPIError, res
    else
      raise UnexpectedAPIError, res
    end
  end

  def user_credentials
    # @user.credentials is an OmniAuth::AuthHash  cerated from request.env['omniauth.auth']['credentials']
    auth.update_token!(access_token: @usuario.token, refresh_token: @usuario.refresh_token) 
    auth
  end

  def refresh_token
    auth.refresh!
    @usuario.update(token: auth.access_token, refresh_token: auth.refresh_token)
    #setup_client_auth
  end
end