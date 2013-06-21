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
    @current_order ||= get_current_order
  end
  helper_method :current_order

  private

  def get_current_order
    if session[:order_id].present?
      current_order = Store::Order.find(session[:order_id])
      current_order.completed_at.present? ? nil : current_order
    end
  rescue => e
    logger.warn "get_current_order failed: #{e.class}: #{e.message}"
    nil
  end

end
