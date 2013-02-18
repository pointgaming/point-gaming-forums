class ApplicationController < ActionController::Base
  before_filter :authenticate_forem_user

  def forem_user
    current_user
  end
  helper_method :forem_user

  protect_from_forgery
end
