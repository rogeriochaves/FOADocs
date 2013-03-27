# encoding: UTF-8
module ApplicationHelper

	def dispatcher_tag
	  controller_name = controller.class.name.underscore
	  controller_name.gsub!(/\//, "_")
	  controller_name.gsub!(/_controller$/, "")

	  %[<meta name="page" content="#{controller_name}##{controller.action_name}" />].html_safe
	end

	class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
		protected

		def html_container(html)
		  tag :div, tag(:ul, html), container_attributes
		end

		def page_number(page)
		  tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
		end

		def gap
		  tag :li, link(super, '#'), :class => 'disabled'
		end

		def previous_or_next_page(page, text, classname)
		  tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
		end
	end

	def page_navigation_links(pages)
		will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
	end

	def error_messages_for(modelo)
		render :partial => 'admin/admin/errors', :locals => {:modelo => modelo}
	end

	def pagina
	    @pagina ||= Pagina.find_by_url(request.fullpath)
	end

	def title
		pagina ? pagina.title : nil
	end

	def description
		pagina ? pagina.description : nil
	end

	def metatags
		pagina ? pagina.metatags.html_safe : nil
	end

	def conteudo_editavel(nome = nil, &block)
		conteudo = capture(&block)
		chave = Digest::MD5.hexdigest(nome ? nome : conteudo)
		if e = Editavel.where(:chave => chave).first
			conteudo = e.texto
		else
			Editavel.create(:chave => chave, :texto => conteudo)
		end
		if current_usuario and current_usuario.admin?
			concat content_tag(:div, conteudo.html_safe, 'data-editavel' => chave) 
		else
			concat conteudo.html_safe
		end
	end

	def image_tag_editavel(src, *args)
		options = args.extract_options!
		size = options[:size]
		if !size
			raise "O método image_tag_editavel precisa ter o :size especificado"
		end
		chave = Digest::MD5.hexdigest(src)
		if @editavel = Editavel.where(:chave => chave).first
			@editavel.size = size
			src = @editavel.foto.url(:small) if @editavel.foto?
		else
			@editavel = Editavel.create(:chave => chave)
		end


		if current_usuario and current_usuario.admin?
			form = "
				<form enctype='multipart/form-data' action='#{url_for :controller => '/admin/editaveis'}/#{chave}' method='post' style='display:inline' onmouseover='this.children[4].style.display = \"block\"; this.children[5].style.display = \"block\"' onmouseout='this.children[4].style.display = \"none\"; this.children[5].style.display = \"none\"'>
					<input name='_method' type='hidden' value='put' />
					<input name='authenticity_token' type='hidden' value='#{form_authenticity_token}' />
					<input name='return_to' type='hidden' value='#{request.url}' />
					<input id='editavel_size' name='editavel[size]' type='hidden' value='#{size}#' />
					<input id='editavel_foto' name='editavel[foto]' type='file' style='position:absolute; display:none' />
					<input type='submit' value='Ok' style='position:absolute; display:none; margin-top:30px' />
					#{image_tag(src, options)}
				</form>
			".html_safe
			content_tag(:div, form, 'data-img-editavel' => chave) 
		else
			image_tag(src, options) 
		end
		
	end

end