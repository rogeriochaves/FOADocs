# encoding: utf-8
require 'test_helper'

class Admin::EditaveisControllerTest < ActionController::TestCase
  setup do
  	login_as(:admin)
    @editavel = editaveis(:one)
  end

  test "should update texto editavel" do
    put :update, :id => @editavel.chave, :texto => "teste"

    assert_equal "ok", JSON.parse(@response.body)['status']
  end

  test "should update imagem editavel" do
    put :update, :return_to => "teste", :id => @editavel.chave, :editavel => { chave: @editavel.chave, texto: @editavel.texto, :size => '100x100', foto: fixture_file_upload('rails.png')  }

    assert_redirected_to "teste"
  end

end
