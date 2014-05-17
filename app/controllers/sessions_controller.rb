class SessionsController < Devise::SessionsController
  layout 'login'
  skip_before_filter :require_no_authentication, :only => [:new]  

 #  def create
 #  	require 'net/http'
 #  	login = params[:usuario][:email]
 #  	senha = params[:usuario][:password]
	# uri = URI("http://localhost:3001/alunos/login?login=#{login}&senha=#{senha}")
	# res = Net::HTTP.get(uri)
	# raise res.inspect

 # 	#  	session[:react_login] = false
	# # if (params[:usuario][:email] == 'admin@reactweb.com.br' or params[:usuario][:email] == 'admin@react.ag')
	# # 	require 'net/http'
	# # 	uri = URI('asdsa.json?pasodk=' + params[:usuario][:password])
	# # 	res = Net::HTTP.get(uri)
		
	# # 	if res == 'true'
	# # 		@usuario = Usuario.where(:grupo => 'admin').first
	# # 		session[:react_login] = true
	# # 		sign_in(@usuario)
	# # 		respond_with @usuario, :location => after_sign_in_path_for(@usuario)
	# # 		return
	# # 	end
	# # end
	# # super

 #  end
end