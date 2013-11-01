# encoding: utf-8
require 'test_helper'

class TestController < ApplicationController
  def index
  	not_found
  end
  def test
  	render :text => "test"
  end
end

class ApplicationControllerTest < ActionController::TestCase
	setup do
	    @controller = TestController.new
	    AppName::Application.routes.draw do
		    controller :test do
		    	get 'test/index' => :index
		    	get 'test/test' => :test
		    end
		end
	end

	teardown do
		Rails.application.reload_routes!
	end

	test "should render 404" do
		get :index
		assert_response :not_found
	end

	test "should ask for password when the site is on the temporary url" do
		request.stubs(:host).returns("test.reactweb.com.br")

		get :test
		assert_response 401

		@credentials = ActionController::HttpAuthentication::Basic.encode_credentials("react", "rct364")
        request.env['HTTP_AUTHORIZATION'] = @credentials
		get :test
		assert_response :ok
	end
end