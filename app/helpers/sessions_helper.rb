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

	#Methods for handling users

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
		reset_session
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	#Methods for handling home feed

  	def set_feed_timescope_default
  		session[:feed_timescope] = "NOW-1DAY" if session[:feed_timescope].blank?
	end

  	def set_feed_timescope
  		if signed_in?
	 	 	session[:feed_timescope] = params[:feed_timescope] 
	  	    redirect_back_or(root_path)
  	 	end
  	end

  	def set_feed_search_default
  		if signed_in?
  			if session[:feed_search].blank? or current_user.searches.find_by_id(session[:feed_search]).nil?
	  			if current_user.searches.blank?
	  				session[:feed_search] = false
				else 
					session[:feed_search] = current_user.searches.first.id
				end
			end
		end
	end

  	def set_feed_search
		session[:feed_search] = params[:feed_search]
		redirect_back_or(root_path)
  	end

end
