class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [:new]  

  def create
  	if !session[:attempts] or session[:attempts] < 3 or verify_recaptcha
  		super
    else
    	@captcha_invalido = true
		render :action => :new
    end   
    
  end
end