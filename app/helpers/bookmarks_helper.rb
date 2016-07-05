module BookmarksHelper
	def can_edit(bookmark)
		return current_user.id == topic.user_id
	end
end
