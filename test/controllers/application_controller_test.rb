# encoding: utf-8
require 'test_helper'

class TestController < ApplicationController
  def index
  	not_found
  end
end

class ApplicationControllerTest < ActionController::TestCase
	setup do
	    @controller = TestController.new
	    AppName::Application.routes.draw do
		    controller :test do
		    	get 'test/index' => :index
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
end