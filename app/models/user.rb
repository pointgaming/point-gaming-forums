class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :session_authenticatable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :points, :password, :password_confirmation, :remember_me, :admin
  # attr_accessible :title, :body

  def to_s
    username
  end
end
