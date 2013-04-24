class AddAvatarThumbUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_thumb_url, :string
  end
end
