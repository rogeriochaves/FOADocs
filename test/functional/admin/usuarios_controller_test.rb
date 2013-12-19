# encoding: utf-8
require 'test_helper'

class Admin::UsuariosControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @usuario_new = {:nome => 'José', :email => 'jose@dasilva2.com', :password => '123mudar', :password_confirmation => '123mudar', :grupo => :usuario}
    @usuario = Usuario.create(:nome => 'José', :email => 'jose@dasilva.com', :password => '123mudar', :password_confirmation => '123mudar', :grupo => :usuario)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usuarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usuario" do
    assert_difference('Usuario.count') do
      post :create, :usuario => @usuario_new
    end

    assert_redirected_to admin_usuario_path(assigns(:usuario))
  end

  test "should show usuario" do
    get :show, :id => @usuario.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @usuario.to_param
    assert_response :success
  end

  test "should update usuario" do
    put :update, :id => @usuario.to_param, :usuario => unprotected_attributes(@usuario)
    assert_redirected_to admin_usuario_path(assigns(:usuario))
  end

  test "should not update password" do
    pass = @usuario.encrypted_password
    atributes = unprotected_attributes(@usuario)
    atributes[:password] = ''
    atributes[:password_confirmation] = ''
    atributes.delete(:encrypted_password)
    put :update, :id => @usuario.to_param, :usuario => atributes
    assert_equal pass, assigns(:usuario).encrypted_password
    assert_redirected_to admin_usuario_path(assigns(:usuario))
  end

  test "should destroy usuario" do
    assert_difference('Usuario.count', -1) do
      delete :destroy, :id => @usuario.to_param
    end

    assert_redirected_to admin_usuarios_path
  end
end