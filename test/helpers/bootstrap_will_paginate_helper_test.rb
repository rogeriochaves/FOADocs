# encoding: utf-8
require 'test_helper'

class BootstrapWillPaginateHelperTest < ActionView::TestCase
	include WillPaginate::ViewHelpers
	include ApplicationHelper

    setup do
        @banners = Banner.all.paginate(:page => params[:page], :per_page => 1)
        @controller = 'banneres'
        
    end

	test "o will_paginate com bootstrap deve ser renderizado corretamente" do

        
        self.stubs(:default_url_options).returns({ :host => "localhost" })
        @template = '<%= will_paginate collection, options %>'
        self.stubs(:template).returns('<%= will_paginate collection, options %>')
        BootstrapLinkRenderer.any_instance.stubs(:link).returns('#')
        
        assert_match /<ul class="pagination">/, page_navigation_links(@banners)
    end

    test "should render gap" do
        @template = mock('template')
        @template.stubs(:will_paginate_translate).returns('#')

        BootstrapLinkRenderer.any_instance.stubs(:link).returns('#')
        link_renderer = BootstrapLinkRenderer.new
        link_renderer.prepare(@banners, {}, @template)
        assert_equal "<li class=\"disabled\">#</li>", link_renderer.gap
    end

end