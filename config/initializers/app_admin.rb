# encoding: utf-8
module AppAdmin
	class << self
	    attr_accessor :app_name, :menu_controllers, :extra_tabs, :domain, :remove_tabs, :react_login
	end

	def self.configure
		yield self if block_given?
	end
end

AppAdmin.configure do |config|

	config.app_name = 'FOADocs'
	config.domain = 'FOADocs.com.br'.downcase
	config.react_login = false

	config.menu_controllers = [['admin/usuarios', 'Usuários'], :projetos, :arquivos]
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