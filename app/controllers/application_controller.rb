class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :prepare_for_mobile
	before_filter :url_salt_valid?

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
      # retrieve input parameters
      params[:timestamp] ? epoch_string = params[:timestamp] : epoch_string = ''
			params[:product] ? product = params[:product] : product = '' 
      params[:encr] ? encr = params[:encr] : encr = ''

 			salt = "234j5gakli2l3k4j5apiosdfj098yasdf!"
 			encrypted_string = Digest::MD5.hexdigest(epoch_string + salt + product)

      # encryptedString should match params[:encr], the input hash
      return false if encr != encrypted_string
      
      # ensure the timestamp is fresh by comparing to current time
			time_difference = Time.now.to_i - epoch_string
      return (time_difference > 0 and time_difference < 10)
		end

end
