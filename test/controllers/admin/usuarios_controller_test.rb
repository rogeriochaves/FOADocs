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

  test "should not create invalid usuario" do
    Usuario.any_instance.stubs(:save).returns(false)
    post :create, usuario: { }

    assert_template :new
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
    put :update, :id => @usuario.to_param, :usuario => @usuario.attributes
    assert_redirected_to admin_usuario_path(assigns(:usuario))
  end

  test "should not update group to remove the last admin" do
    put :update, :id => usuarios(:admin).to_param, usuario: { grupo: 'usuario' }

    assert_template :edit
  end

  test "should not update invalid usuario" do
    Usuario.any_instance.stubs(:update).returns(false)
    put :update, :id => usuarios(:usuario_comum).to_param, usuario: { }

    assert_template :edit
  end

  test "should not update password" do
    pass = @usuario.encrypted_password
    atributes = @usuario.attributes
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

  test "não deve destruir o último admin" do
    assert_difference('Usuario.count', 0) do
      delete :destroy, :id => usuarios(:admin).to_param
    end

    assert_redirected_to admin_usuarios_path
  end

  # test "should be redirected to change password for the first login" do
  #   usuarios(:admin).update_attribute(:change_password, true)
  #   get :index
  #   assert_redirected_to :action => :change_password
  #   usuarios(:admin).update_attribute(:change_password, false)
  # end

  # test "should change password at the first login" do
  #   user = usuarios(:admin)
  #   self.stubs(:current_usuario).returns(user)
  #   assert_equal false, user.valid_password?("testing password")
  #   #assert_equal true, current_usuario.change_password 
  #   put :change_password, usuario: {
  #     password: "testing password",
  #     password_confirmation: "testing password"
  #   }
  #   user = user.reload
  #   assert_equal true, user.valid_password?("testing password")
  #   assert_equal false, user.change_password 
  # end

  test "should not have accessed without being logged" do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
    @ability.cannot :manage, Usuario
    get :index
    assert_redirected_to :controller => '/admin/admin', :action => :index
    sign_out(:usuario)
    get :index
    assert_redirected_to new_usuario_session_path
  end
end