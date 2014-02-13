require 'test_helper'

class ArquivosControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @arquivo = arquivos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arquivos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arquivo" do
    assert_difference('Arquivo.count') do
      post :create, arquivo: { arquivo_id: @arquivo.arquivo_id, diretorio: @arquivo.diretorio, download_url: @arquivo.download_url, etag: @arquivo.etag, file_id: @arquivo.file_id, icon_link: @arquivo.icon_link, mime_type: @arquivo.mime_type, nome: @arquivo.nome, projeto_id: @arquivo.projeto_id, tamanho: @arquivo.tamanho }
    end

    assert_redirected_to arquivo_path(assigns(:arquivo))
  end

  test "should not save invalid arquivo" do
    Arquivo.any_instance.stubs(:save).returns(false)
    post :create, arquivo: { }

    assert_template :new
  end

  test "should show arquivo" do
    get :show, id: @arquivo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arquivo
    assert_response :success
  end

  test "should update arquivo" do
    patch :update, id: @arquivo, arquivo: { arquivo_id: @arquivo.arquivo_id, diretorio: @arquivo.diretorio, download_url: @arquivo.download_url, etag: @arquivo.etag, file_id: @arquivo.file_id, icon_link: @arquivo.icon_link, mime_type: @arquivo.mime_type, nome: @arquivo.nome, projeto_id: @arquivo.projeto_id, tamanho: @arquivo.tamanho }
    assert_redirected_to arquivo_path(assigns(:arquivo))
  end

  test "should not update invalid arquivo" do
    Arquivo.any_instance.stubs(:update).returns(false)
    put :update, id: @arquivo.to_param, arquivo: { }

    assert_template :edit
  end

  test "should destroy arquivo" do
    assert_difference('Arquivo.count', -1) do
      delete :destroy, id: @arquivo
    end

    assert_redirected_to arquivos_path
  end
end
