# frozen_string_literal: true

module CommentsHelper
  def current_user_name(user)
    [user.name, user.email].find(&:present?)
  end
end
