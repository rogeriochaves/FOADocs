# encoding: utf-8
require 'test_helper'

class EditablesControllerTest < ActionController::TestCase
  setup do
  	login_as(:admin)
    @editable = editables(:one)
  end

  test "should update editable text" do
    put :update, :id => @editable.key, :text => "teste"

    assert_equal "ok", JSON.parse(@response.body)['status']
  end

  test "should update editable image" do
    put :update, :return_to => "teste", :id => @editable.key, :editable => { key: @editable.key, text: @editable.text, :size => '100x100', picture: fixture_file_upload('rails.png')  }

    assert_redirected_to "teste"
  end

end
