# frozen_string_literal: true

module CommentsHelper
  def comment_user_name(user)
    user.name.nil? || user.name.empty? ? user.email : user.name
  end
end
