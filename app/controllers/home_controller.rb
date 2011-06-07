class HomeController < ApplicationController
  skip_before_filter :url_salt_valid?
  
  def index
  end

end
