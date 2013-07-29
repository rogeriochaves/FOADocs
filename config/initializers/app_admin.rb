# encoding: utf-8
module AppAdmin
	class << self
	    attr_accessor :app_name, :menu_controllers, :extra_tabs, :domain, :remove_tabs
	end

	def self.configure
		yield self if block_given?
	end
end

AppAdmin.configure do |config|

	config.app_name = 'AppName'
	config.domain = 'AppName.com.br'.downcase

	config.menu_controllers = [['admin/usuarios', 'Usuários'], ['admin/paginas', 'SEO'], 'admin/mensagens', ['banneres', 'Banners']]
	config.extra_tabs = {
	  'Banneres' => [
	    ['Ordenar', :ordenar]
	  ],
	  #'Anuncios' => [
	  #  ['Descontos', :id, :descontos]
	  #]
	}
	config.remove_tabs = {
		'Mensagens' => [:edit, :new, :destroy]
	}


end