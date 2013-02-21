class AddModerationRequiredToForemForums < ActiveRecord::Migration
  def change
    add_column :forem_forums, :moderation_required, :boolean
  end
end
