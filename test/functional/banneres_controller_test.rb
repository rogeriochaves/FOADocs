require 'test_helper'

class BanneresControllerTest < ActionController::TestCase
  setup do
    @banner = banneres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banneres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banner" do
    assert_difference('Banner.count') do
      post :create, banner: { foto: @banner.foto, link: @banner.link, nome: @banner.nome }
    end

    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should show banner" do
    get :show, id: @banner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banner
    assert_response :success
  end

  test "should update banner" do
    put :update, id: @banner, banner: { foto: @banner.foto, link: @banner.link, nome: @banner.nome }
    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should destroy banner" do
    assert_difference('Banner.count', -1) do
      delete :destroy, id: @banner
    end

    assert_redirected_to banneres_path
  end
end
