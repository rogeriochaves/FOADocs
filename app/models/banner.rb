class Banner < ActiveRecord::Base
  attr_accessible :foto, :link, :nome, :position
  has_attached_file :foto, :styles => {:small => "272x104#", :big => '1366x529#'}

  def http_link
  	if self.link and !self.link.empty?
  		return 'http://' + self.link.sub('http://', '')
  	end
  	return nil
  end
end
