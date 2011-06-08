class ApplicationController < ActionController::Base
  #protect_from_forgery

	before_filter :prepare_for_mobile
	#before_filter :url_salt_valid?

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
			request.format = :mobile if mobile_device?
		end

		def url_salt_valid?
      logger.debug "I entered the bowels of Rails"

      # retrieve input parameters
      if params[:timestamp] 
        epoch_string = params[:timestamp]
      else 
        flash[:notice] = "No"
        return redirect_to root_path
      end
      if params[:product]
        product = params[:product]
      else
        flash[:notice] = "No"
        return redirect_to root_path 
      end
      if params[:encr] 
        encr = params[:encr]
      else
        flash[:notice] = "No"
        return redirect_to root_path
      end
      
      logger.debug "... and it stunk"
      
 			salt = "234j5gakli2l3k4j5apiosdfj098yasdf!"
 			encrypted_string = Digest::MD5.hexdigest(epoch_string + salt + product)

      # encryptedString should match params[:encr], the input hash
      if encr != encrpyted_string
        flash[:notice] = "No"
        return redirect_to root_path
      end
      
      logger.debug "... but then it had a beano"
      
      # ensure the timestamp is fresh by comparing to current time
			time_difference = Time.now.to_i - epoch_string.to_i
			if (time_difference > 0 && time_difference < 60)
			  logger.debug "... and we were in love and had buttsecks"
      else
        flash[:notice] = "No"
        return redirect_to root_path
      end
		end

end
