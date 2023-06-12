# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :content
  end
end
