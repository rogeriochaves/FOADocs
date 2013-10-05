require 'test_helper'

class BanneresControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
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
      post :create, banner: { foto: fixture_file_upload('rails.png'), link: @banner.link, nome: @banner.nome }
    end

    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should not save invalid banner" do
    Banner.any_instance.stubs(:save).returns(false)
    post :create, banner: { }

    assert_template :new
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
    put :update, id: @banner, banner: { foto: fixture_file_upload('rails.png'), link: @banner.link, nome: @banner.nome }
    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should not update invalid banner" do
    Banner.any_instance.stubs(:update).returns(false)
    put :update, id: @banner.to_param, banner: { }

    assert_template :edit
  end

  test "should destroy banner" do
    assert_difference('Banner.count', -1) do
      delete :destroy, id: @banner
    end

    assert_redirected_to banneres_path
  end

  test "should list banners to order" do
    get :ordenar
    assert_response :success
  end

  test "should save updated order" do
    post :ordenar, banner: [banneres(:two).id, banneres(:one).id]
    assert_equal 2, banneres(:one).reload.position
  end
end
