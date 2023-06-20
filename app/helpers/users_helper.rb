# frozen_string_literal: true

module UsersHelper
  def name_or_email(user)
    user.name.presence || user.email
  end
end
