class ApplicationController < ActionController::Base
  include ::SslRequirement

  def forem_user
    current_user
  end
  helper_method :forem_user

  protect_from_forgery

  def current_pg_user
    return nil unless forem_user.present?
    forem_user.pg_user
  end
  helper_method :current_pg_user

  def current_order
    return @current_order if @current_order

    @current_order = nil
    if session[:order_id]
      current_order = Store::Order.find session[:order_id]
      @current_order = current_order if current_order && current_order.state === 'cart'
    end

    @current_order
  end
  helper_method :current_order

end
