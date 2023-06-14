# frozen_string_literal: true

module CommentsHelper
  def comment_user_name(user)
    user.name || user.email
  end
end
