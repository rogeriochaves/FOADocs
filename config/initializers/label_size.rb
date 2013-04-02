class ActionView::Helpers::FormBuilder
  alias :orig_label :label

  # add a '*' after the field label if the field is required
  def label(method, content_or_options = nil, options = nil, &block)
    if content_or_options && content_or_options.class == Hash
      options = content_or_options
    else
      content = content_or_options
    end

    tamanho = ''
    begin
      if object.send(method).respond_to?('styles')
        max_num = 0
        object.send(method).send('styles').each do |key, style|
          size = style.geometry.sub(/[\^#>]/, '')
          area = size.split('x')[0].to_i * size.split('x')[1].to_i
          if area > max_num
            max_num = area
            tamanho = " (#{size.html_safe})"
          end
        end
      end
    rescue; end
    #required_mark = ''
    #required_mark = ' *'.html_safe if object.class.validators_on(method).map(&:class).include? ActiveModel::Validations::PresenceValidator

    content ||= method.to_s.humanize
    content = content + tamanho

    self.orig_label(method, content, options || {}, &block)
  end
end