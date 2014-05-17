# encoding: utf-8
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "dispatcher_tag deve colocar o nome do controller e da action corretamente" do
    	assert_equal "<meta name=\"page\" content=\"action_view_test_case_test#\" />", dispatcher_tag
    end

  #   # para SEO
  #   test "deverá retornar o title, description e metatags corretamente" do
  #       request = mock('request')

  #       # caso a página não esteja cadastrada, deve retornar nil
  #   	request.stubs(:fullpath).returns('/teste')
		# self.stubs(:request).returns(request)
  #       assert_equal nil, title
  #       assert_equal nil, title('/teste')
  #       assert_equal nil, description
  #       assert_equal nil, metatags

  #       # caso a página esteja cadastrada, deve retornar corretamente
  #       request.stubs(:fullpath).returns('/contato')
  #       self.stubs(:request).returns(request)
  #       assert_equal paginas(:contato).title, title
  #       assert_equal paginas(:contato).title, title('/contato')
  #       assert_equal paginas(:contato).description, description
  #       assert_equal paginas(:contato).metatags, metatags
  #   end

    test "deve renderizar mensagens de erro" do
        @usuario = Usuario.new
        @usuario.save
        assert_match /Nome não pode ser vazio/, error_messages_for(@usuario)
    end

end