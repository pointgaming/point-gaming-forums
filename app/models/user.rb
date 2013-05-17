class User < ActiveRecord::Base
  before_validation :populate_slug

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :session_authenticatable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :admin, :avatar_thumb_url
  # attr_accessible :title, :body

  def to_s
    username
  end

  def pg_user
    @PgUser ||= PgUser.find(1, params: { slug: self.slug })
  rescue
    nil
  end

  def forem_admin?
    pg_user.present? && pg_user.respond_to?(:group) && pg_user.group.permissions.include?('forums_admin')
  end

  def populate_slug
    self.slug = self.username.downcase.gsub(/\s/, "_") if self.username.present?
    true
  end
end
