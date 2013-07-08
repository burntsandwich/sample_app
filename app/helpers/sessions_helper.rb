module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_path, notice: "Please sign in."
		end
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end

  	def set_feed_timescope
  	  if params[:feed_timescope]	
	  	session[:feed_timescope] = params[:feed_timescope] 
	    redirect_back_or(root_path)
	  elsif session[:feed_timescope].nil?
	  	session[:feed_timescope] = "NOW-1DAY"
	  end
  	end

  	def set_feed_query
  		if params[:feed_query]
  			session[:feed_query] = params[:feed_query]
  			redirect_back_or(root_path)
		elsif session[:feed_query].nil?
			if current_user.searches.count > 0
				session[:feed_query] = current_user.searches.first.query
			else session[:feed_query] = "no search defined"
			end
		end
  	end

end
