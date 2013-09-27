require 'test_helper'

class BootstrapWillPaginateHelperTest < ActionView::TestCase
	include WillPaginate::ViewHelpers
	include ApplicationHelper
=begin
	test "o will_paginate com bootstrap deve ser renderizado corretamente" do
        @banners = Banner.all.paginate(:page => params[:page], :per_page => 1)

        @controller = 'banneres'
        self.stubs(:default_url_options).returns({ :host => "localhost" })
        @template = '<%= will_paginate collection, options %>'
        self.stubs(:template).returns('<%= will_paginate collection, options %>')

        raise page_navigation_links(@banners).to_s

        assert_equal "<meta name=\"page\" content=\"action_view_test_case_test#\" />", page_navigation_links(@banners)
    end
=end
end