# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  validate :avatar_content_type, if: :was_attached?

  def avatar_content_type
    extension = ['image/jpg', 'image/png', 'image/gif']
    errors.add(:avatar, "の拡張子が間違っています") unless avatar.in?(extension)
  end

  def was_attached?
    self.avatar.attached?
  end
end
