class <%= controller_class_name %>Controller < ApplicationController
<% unless options[:singleton] -%>
	before_filter :authenticate_usuario!
	load_and_authorize_resource
	layout 'administrativo'

	# GET /<%= table_name %>
	def index
		@<%= plural_name %> = <%= singular_name.capitalize %>.paginate page: params[:page]
	end
<% end -%>

	# GET /<%= table_name %>/1
	def show
		@<%= file_name %> = <%= singular_name.capitalize %>.find(params[:id])
	end

	# GET /<%= table_name %>/new
	def new
		@<%= file_name %> = <%= singular_name.capitalize %>.new
	end

	# GET /<%= table_name %>/1/edit
	def edit
		@<%= file_name %> = <%= singular_name.capitalize %>.find(params[:id])
	end

	# POST /<%= table_name %>
	def create
		@<%= file_name %> = <%= singular_name.capitalize %>.new(params[:<%= file_name %>])

		if @<%= file_name %>.save
		  <% if controller_class_name.include? '::' %>redirect_to([:<%= controller_class_name.split('::')[0].downcase %>, @<%= file_name %>], notice: '<%= human_name %> criado com sucesso.')
		  <% else %>redirect_to(@<%= file_name %>, notice: '<%= human_name %> criado com sucesso.')
		  <% end %>
		else
		  render action: "new"
		end
	end

	# PUT /<%= table_name %>/1
	def update
		@<%= file_name %> = <%= singular_name.capitalize %>.find(params[:id])

		if @<%= file_name %>.update(params[:<%= file_name %>])
		  <% if controller_class_name.include? '::' %>redirect_to([:<%= controller_class_name.split('::')[0].downcase %>, @<%= file_name %>], notice: '<%= human_name %> atualizado com sucesso.')
		  <% else %>redirect_to(@<%= file_name %>, notice: '<%= human_name %> atualizado com sucesso.')
		  <% end %>
		else
		  render action: "edit"
		end
	end

	# DELETE /<%= table_name %>/1
	def destroy
		@<%= file_name %> = <%= singular_name.capitalize %>.find(params[:id])
		@<%= file_name %>.destroy

		redirect_to <%= table_name %>_url
	end
end