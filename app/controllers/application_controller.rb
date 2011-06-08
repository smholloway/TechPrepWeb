class ApplicationController < ActionController::Base
  #protect_from_forgery

	before_filter :prepare_for_mobile
	#before_filter :url_salt_valid?

  protected

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "essoress" && password == "234j5gakli2l3k4j5apiosdfj098yasdf!"
      end
    end

	private

		def mobile_device?
			if session[:mobile_param]
				session[:mobile_param] == "1"
			else
				request.user_agent =~ /Mobile|webOS/
			end
		end

		helper_method :mobile_device?

		def prepare_for_mobile
			session[:mobile_param] = params[:mobile] if params[:mobile]
			if mobile_device?
  			request.format = :mobile 
      else
			  authenticate
		  end
		end

		def url_salt_valid?
      #logger.debug "I entered the bowels of Rails"

      # retrieve input parameters
      if (params[:timestamp] && params[:product] && params[:encr])
        epoch_string = params[:timestamp]
        product = params[:product]
        encr = params[:encr]
      else 
        flash[:notice] = "No"
        return redirect_to root_path
      end
      
 			salt = "234j5gakli2l3k4j5apiosdfj098yasdf!"
 			encrypted_string = Digest::MD5.hexdigest(epoch_string + salt + product)

      # encryptedString should match params[:encr], the input hash
      if encr != encrpyted_string
        flash[:notice] = "No"
        return redirect_to root_path
      end
      
      # ensure the timestamp is fresh by comparing to current time
			time_difference = Time.now.to_i - epoch_string.to_i
			if (time_difference > 0 && time_difference < 60)
			  return true
      else
        flash[:notice] = "No"
        return redirect_to root_path
      end
		end

end
