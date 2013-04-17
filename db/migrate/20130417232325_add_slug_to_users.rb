class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string

    User.reset_column_information
    User.find_each {|u| u.save! }

    add_index :users, :slug, :unique => true

    User.reset_column_information
  end
end
