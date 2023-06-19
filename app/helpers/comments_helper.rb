# frozen_string_literal: true

module CommentsHelper
  def comment_user_name(user)
    user.name.presence || user.email
  end
end
