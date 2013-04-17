class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :session_authenticatable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :admin
  # attr_accessible :title, :body

  def to_s
    username
  end

  def pg_user
    @PgUser ||= PgUser.find(self.username)
  rescue
    nil
  end

  def forem_admin?
    pg_user && pg_user.group && pg_user.group.permissions.include?('forums_admin')
  end
end
