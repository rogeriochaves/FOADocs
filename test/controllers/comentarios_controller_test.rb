require 'test_helper'

class ComentariosControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @comentario = comentarios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comentario" do
    assert_difference('Comentario.count') do
      post :create, comentario: { comentario: @comentario.comentario, usuario_id: @comentario.usuario_id, versao_id: @comentario.versao_id }
    end

    assert_redirected_to comentario_path(assigns(:comentario))
  end

  test "should not save invalid comentario" do
    Comentario.any_instance.stubs(:save).returns(false)
    post :create, comentario: { }

    assert_template :new
  end

  test "should show comentario" do
    get :show, id: @comentario
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comentario
    assert_response :success
  end

  test "should update comentario" do
    patch :update, id: @comentario, comentario: { comentario: @comentario.comentario, usuario_id: @comentario.usuario_id, versao_id: @comentario.versao_id }
    assert_redirected_to comentario_path(assigns(:comentario))
  end

  test "should not update invalid comentario" do
    Comentario.any_instance.stubs(:update).returns(false)
    put :update, id: @comentario.to_param, comentario: { }

    assert_template :edit
  end

  test "should destroy comentario" do
    assert_difference('Comentario.count', -1) do
      delete :destroy, id: @comentario
    end

    assert_redirected_to comentarios_path
  end
end
