class ApplicationController < ActionController::Base
  include ::SslRequirement

  def pg_user_id
    session.has_key?('warden.user.user.key') ? session['warden.user.user.key'].at(1).first : nil
  end
  helper_method :pg_user_id

  def forem_user
    current_user
  end
  helper_method :forem_user

  protect_from_forgery

  def current_pg_user
    return nil unless forem_user

    @PgUser ||= PgUser.find(forem_user.slug)
  rescue
    nil
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
