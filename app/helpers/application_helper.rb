# encoding: UTF-8
module ApplicationHelper

	def btt_remove
		'<span class="btn btn-danger pull-right">x</span>'.html_safe
	end

	def btt_add(item)
		"<span class=\"btn btn-default\" style=\"margin-left:130px\">Adicionar #{item}</span>".html_safe
	end

	def dispatcher_tag
	  controller_name = controller.class.name.underscore
	  controller_name.gsub!(/\//, "_")
	  controller_name.gsub!(/_controller$/, "")

	  return %[<meta name="page" content="#{controller_name}##{controller.action_name}" />].html_safe
	end

	def page_navigation_links(pages)
		will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
	end

	def error_messages_for(modelo)
		render :partial => 'admin/admin/errors', :locals => {:modelo => modelo}
	end

	def title(p = false)
		"FOADocs"
	end

	def description
		"Um projeto Fodocs"
	end

	def metatags
		""
	end

	# Editable Content
	def editable_content(name = nil, &block)
		contents = capture(&block)
		key = Digest::MD5.hexdigest(name ? name : contents)
		e = Editable.find_by_key(key) || Editable.create(:key => key, :text => contents)
		contents = e.text if !e.text.empty?

		if can_change_editable_content?
			return content_tag(:div, contents.html_safe, 'data-editable' => key) 
		else
			return contents.html_safe
		end
	end

	def editable_image_tag(src, *args)
		options = args.extract_options!
		size = options[:size]
		if !size
			raise "The attribute :size must be specified on editable_image_tag"
		end
		key = Digest::MD5.hexdigest(src)
		if @editable = Editable.where(:key => key).first
			@editable.size = size
			src = @editable.picture.url(:small) if @editable.picture?
		else
			@editable = Editable.create(:key => key)
		end

		if can_change_editable_content?
			form = "
				<form enctype='multipart/form-data' action='#{url_for :controller => '/editables', :action => :update, :id => key}' method='post' style='display:inline' onmouseover='this.children[4].style.display = \"block\"; this.children[5].style.display = \"block\"' onmouseout='this.children[4].style.display = \"none\"; this.children[5].style.display = \"none\"'>
					<input name='_method' type='hidden' value='put' />
					<input name='authenticity_token' type='hidden' value='#{form_authenticity_token}' />
					<input name='return_to' type='hidden' value='#{request.url}' />
					<input id='editable_size' name='editable[size]' type='hidden' value='#{size}#' />
					<input id='editable_picture' name='editable[picture]' type='file' style='position:absolute; display:none' />
					<input type='submit' value='Ok' style='position:absolute; display:none; margin-top:30px' />
					#{image_tag(src, options)}
				</form>
			".html_safe
			content_tag(:div, form, 'data-img-editable' => key) 
		else
			image_tag(src, options) 
		end
		
	end

	def can_change_editable_content?
		(current_usuario and can? :manage, :editables)
	end

end