# encoding: utf-8
require 'test_helper'

class Admin::MensagensControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @mensagem = mensagens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mensagens)
  end

  test "should show mensagem" do
    get :show, id: @mensagem
    assert_response :success
  end
end
