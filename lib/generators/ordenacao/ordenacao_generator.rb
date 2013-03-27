# encoding: utf-8
class OrdenacaoGenerator < Rails::Generators::Base
	source_root File.expand_path('../templates', __FILE__)  
	argument :para, :type => :string

	def generate_ordenacao

		def gsub_file(relative_destination, regexp, *args, &block)
			path = Rails.root + relative_destination
			content = File.read(path).gsub(regexp, *args, &block)
			File.open(path, 'wb') { |file| file.write(content) }
		end

		def in_file(relative_destination, string)
			path = Rails.root + relative_destination
			if string.is_a? Regexp
				File.read(path).match string
			else
				File.read(path).include?(string)
			end
		end

		modelo = para.underscore

		#===== Copy the View =====#
		copy_file "ordenar.html.erb", "app/views/#{modelo}/ordenar.html.erb"

		#===== Add action to controller ====#
		controller = "app/controllers/#{modelo}_controller.rb"
		
		if !in_file(controller, "def ordenar")
			gsub_file controller, /(end[ \t\n]*\Z)/i do |match|

"	def ordenar
		@list = controller_name.classify.constantize.order(:position)
		if request.post?
			@list.each do |m|
				m.position = params[controller_name.singularize].index(m.id.to_s) + 1
				m.save
			end
			render :nothing => true
		end
	end\n\n#{match}"

			end
			say_status "added", "Método adicionado ao Controller", :green
		else
			say_status "já adicionado", "Método ordenar já existe no controller", :blue
		end

		#===== Add route =====#

		routes = "config/routes.rb"
		add = "match '#{modelo}/ordenar' => '#{modelo}#ordenar'"
		if !in_file(routes, add)
			gsub_file routes, /(#{Regexp.escape("Application.routes.draw do")})/i do |match|

"#{match}\n\n	#{add}\n"

			end
			say_status "added", "Rota adicionada", :green
		else
			say_status "já adicionado", "Rota já foi adicionada", :blue
		end

		#==== Create migration ====#

		@camel = modelo.camelize
		if @camel.include? "::"
			@camel = @camel.split("::")[-1]
		end
		@plural = @camel.underscore.pluralize
		migration_name = "add_position_to_#{@plural}"

		exist = false
		files = Dir.glob(Rails.root + "db/migrate/*")
		for file in files
		    if file.include? migration_name
		    	exist = true
		    end
		end
		if !exist
			template "add_position.rb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_#{migration_name}.rb"
		else
			say_status "já existe", "Migração já existe", :blue
		end

		#=== Add to attr_accessible ===#

		model_file = "app/models/#{@camel.underscore.singularize}.rb"
		if !in_file(model_file, /attr_accessible(.*):position$/)
			gsub_file model_file, /attr_accessible(.*)$/i do |match|

"#{match}, :position"

			end
			say_status "added", "Atributo adicionado ao attr_accessible", :green
		else
			say_status "já adicionado", "Atributo já adicionado ao attr_accessible", :blue
		end

	end

end