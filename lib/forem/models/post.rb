Forem::Post.class_eval do

protected

  def skip_pending_review
    unless forum.moderation_required
      update_attribute(:state, 'approved')
    end
  end
end
