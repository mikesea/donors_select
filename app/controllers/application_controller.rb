class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_session

  def set_session
    self.session_token || self.session_token = {
      value: rand(36**8).to_s(36),
      expires: 1.hour.from_now
    }
  end

  def session_token=(token)
    cookies.signed[:token] = token
  end

  def session_token
    cookies.signed[:token]
  end
end
