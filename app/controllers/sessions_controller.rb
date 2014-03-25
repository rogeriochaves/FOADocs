class SessionsController < Devise::SessionsController
  layout 'login'
  skip_before_filter :require_no_authentication, :only => [:new]  

  def create
  	super
  end
end