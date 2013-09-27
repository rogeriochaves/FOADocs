require 'test_helper'

class BannerTest < ActiveSupport::TestCase
	test "should return corrected formated links" do
	    assert_equal "http://www.google.com", banneres(:one).http_link
	    assert_equal "http://www.google.com", banneres(:two).http_link
	    assert_equal nil, banneres(:three).http_link
	end
end
