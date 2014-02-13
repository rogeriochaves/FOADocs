require 'test_helper'

class NotificacoesControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @notificacao = notificacoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notificacoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notificacao" do
    assert_difference('Notificacao.count') do
      post :create, notificacao: { arquivo_id: @notificacao.arquivo_id, comentario_id: @notificacao.comentario_id, lido: @notificacao.lido, texto: @notificacao.texto, usuario_id: @notificacao.usuario_id, versao_id: @notificacao.versao_id }
    end

    assert_redirected_to notificacao_path(assigns(:notificacao))
  end

  test "should not save invalid notificacao" do
    Notificacao.any_instance.stubs(:save).returns(false)
    post :create, notificacao: { }

    assert_template :new
  end

  test "should show notificacao" do
    get :show, id: @notificacao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notificacao
    assert_response :success
  end

  test "should update notificacao" do
    patch :update, id: @notificacao, notificacao: { arquivo_id: @notificacao.arquivo_id, comentario_id: @notificacao.comentario_id, lido: @notificacao.lido, texto: @notificacao.texto, usuario_id: @notificacao.usuario_id, versao_id: @notificacao.versao_id }
    assert_redirected_to notificacao_path(assigns(:notificacao))
  end

  test "should not update invalid notificacao" do
    Notificacao.any_instance.stubs(:update).returns(false)
    put :update, id: @notificacao.to_param, notificacao: { }

    assert_template :edit
  end

  test "should destroy notificacao" do
    assert_difference('Notificacao.count', -1) do
      delete :destroy, id: @notificacao
    end

    assert_redirected_to notificacoes_path
  end
end
