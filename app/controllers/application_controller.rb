class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_session

  def set_session
    unless cookies.signed[:token]
      cookies.signed[:token] = { value: rand(36**8).to_s(36),
        expires: 1.hour.from_now
      }
    end
  end
end
