require 'test_helper'

class VersoesControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @versao = versoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:versoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create versao" do
    assert_difference('Versao.count') do
      post :create, versao: { alteracao: @versao.alteracao, arquivo_id: @versao.arquivo_id, conteudo: @versao.conteudo, download_url: @versao.download_url, last_modifying_user_name: @versao.last_modifying_user_name, modified_date: @versao.modified_date, revision_id: @versao.revision_id, tamanho: @versao.tamanho }
    end

    assert_redirected_to versao_path(assigns(:versao))
  end

  test "should not save invalid versao" do
    Versao.any_instance.stubs(:save).returns(false)
    post :create, versao: { }

    assert_template :new
  end

  test "should show versao" do
    get :show, id: @versao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @versao
    assert_response :success
  end

  test "should update versao" do
    patch :update, id: @versao, versao: { alteracao: @versao.alteracao, arquivo_id: @versao.arquivo_id, conteudo: @versao.conteudo, download_url: @versao.download_url, last_modifying_user_name: @versao.last_modifying_user_name, modified_date: @versao.modified_date, revision_id: @versao.revision_id, tamanho: @versao.tamanho }
    assert_redirected_to versao_path(assigns(:versao))
  end

  test "should not update invalid versao" do
    Versao.any_instance.stubs(:update).returns(false)
    put :update, id: @versao.to_param, versao: { }

    assert_template :edit
  end

  test "should destroy versao" do
    assert_difference('Versao.count', -1) do
      delete :destroy, id: @versao
    end

    assert_redirected_to versoes_path
  end
end
