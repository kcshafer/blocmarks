module TopicsHelper
  def can_edit(topic)
    return current_user.id == topic.user_id
  end
end
