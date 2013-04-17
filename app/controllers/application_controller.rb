class ApplicationController < ActionController::Base

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

    @PgUser ||= PgUser.find(forem_user.username)
  rescue
    nil
  end
  helper_method :current_pg_user
end
