# encoding: utf-8
require 'test_helper'
require 'Ability'

class EditablesHelperTest < ActionView::TestCase
	include ApplicationHelper
	include Devise::TestHelpers 
	include CanCan::Ability

	setup do
		self.stubs(:current_usuario).returns(usuarios(:admin))
		ability = Ability.new(usuarios(:admin))
		self.stubs(:can?).returns(ability.can?(:manage, :editables))
		self.stubs(:form_authenticity_token).returns('token')
		request = mock('request')
    	request.stubs(:url).returns('/test')
		self.stubs(:request).returns(request)
	end

	# Editable Text
	test "should create new editable for new key, and use the existent for existent ones" do
		assert_difference('Editable.count') do
			a = editable_content do
				"test 1"
			end
		end
		assert_difference('Editable.count', 0) do
			editable_content do
				"test 1"
			end
		end
		assert_difference('Editable.count') do
			editable_content('test 2') do
				"test 2"
			end
		end
		assert_difference('Editable.count', 0) do
			editable_content('test 2') do
				"test 2"
			end
		end
	end

	test "admin should be able to change editable contents, normal users shouldn't" do
		self.stubs(:current_usuario).returns(nil)
		ability = Ability.new(nil)
		self.stubs(:can?).returns(ability.can?(:manage, :editables))
		assert_equal false, !!can_change_editable_content?

		self.stubs(:current_usuario).returns(usuarios(:admin))
		ability = Ability.new(usuarios(:admin))
		self.stubs(:can?).returns(ability.can?(:manage, :editables))
		assert_equal true, can_change_editable_content?
	end

	test "should render only text for not logged users" do
		self.stubs(:current_usuario).returns(nil)
		editable = editable_content do
			"text test"
		end
		assert_equal "text test", editable
	end

	test "should render editable content to alowed logged users" do
		editable = editable_content do
			"text test"
		end
		assert_match /data-editable/, editable
	end

	# Editable Images
	test "editable_image_tag without size should raise an error" do
		assert_raises(RuntimeError) { editable_image_tag "rails.png" }
	end

	test "should create new editable image for new key, and use the existent for existent ones" do
		assert_difference('Editable.count') do
			editable_image_tag "test1.png", :size => "50x50"
		end
		assert_difference('Editable.count', 0) do
			editable_image_tag "test1.png", :size => "50x50"
		end
	end

	test "should render only img for not logged users" do
		self.stubs(:current_usuario).returns(nil)
		assert_equal "<img alt=\"Rails\" height=\"50\" src=\"/images/rails.png\" width=\"50\" />", editable_image_tag("rails.png", :size => "50x50")
	end

	test "should render editable image to alowed logged users" do
		assert_match /data-img-editable/, editable_image_tag("rails.png", :size => "50x50")
	end
end