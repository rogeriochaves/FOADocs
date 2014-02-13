require 'test_helper'

class ProjetosControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @projeto = projetos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projetos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projeto" do
    assert_difference('Projeto.count') do
      post :create, projeto: { data_inicio: @projeto.data_inicio, fechado: @projeto.fechado, nome: @projeto.nome, tipo: @projeto.tipo }
    end

    assert_redirected_to projeto_path(assigns(:projeto))
  end

  test "should not save invalid projeto" do
    Projeto.any_instance.stubs(:save).returns(false)
    post :create, projeto: { }

    assert_template :new
  end

  test "should show projeto" do
    get :show, id: @projeto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @projeto
    assert_response :success
  end

  test "should update projeto" do
    patch :update, id: @projeto, projeto: { data_inicio: @projeto.data_inicio, fechado: @projeto.fechado, nome: @projeto.nome, tipo: @projeto.tipo }
    assert_redirected_to projeto_path(assigns(:projeto))
  end

  test "should not update invalid projeto" do
    Projeto.any_instance.stubs(:update).returns(false)
    put :update, id: @projeto.to_param, projeto: { }

    assert_template :edit
  end

  test "should destroy projeto" do
    assert_difference('Projeto.count', -1) do
      delete :destroy, id: @projeto
    end

    assert_redirected_to projetos_path
  end
end
