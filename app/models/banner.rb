class Banner < ActiveRecord::Base
  	has_attached_file :foto, :styles => {:small => "272x104#", :big => '1366x529#'}

	def http_link
		if self.link and !self.link.empty?
			return (self.link.include?("https") ? 'https://' : "http://") + self.link.sub('http://', '').sub('https://', '')
		end
		return nil
	end
end
