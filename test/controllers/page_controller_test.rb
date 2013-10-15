# encoding: utf-8
require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get index" do 
    get :index
    assert_response :success
  end

  test "should get contato" do
    get :contato
    assert_response :success
  end

  test "should send contato" do
    post :contato, :mensagem => {nome: 'Test', email: 'test@test.com', telefone: '1234-5678', mensagem: 'test message'}

    assert_template :ok
  end

  test "should get ok" do
    get :ok
    assert_response :success
  end

end
