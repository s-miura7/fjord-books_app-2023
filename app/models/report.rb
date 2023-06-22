# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :given_mentions, class_name: 'ReportMention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned
  has_many :received_mentions, class_name: 'ReportMention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioning

  has_many :mentioning_reports, through: :given_mentions, source: :mentioning
  has_many :mentioned_reports, through: :received_mentions, source: :mentioned

  validates :title, presence: true
  validates :content, presence: true

  after_save :update_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def update_mentions
    mentionings.destroy_all
    new_keys = content.scan(%r{(?:http://localhost:3000/reports/)(\d+)}).flatten
    new_keys.each { |key| mentionings.create(mentioning_id: key) }
  end
end
