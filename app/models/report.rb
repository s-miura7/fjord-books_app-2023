# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning, class_name: 'ReportMention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned
  has_many :mentioned, class_name: 'ReportMention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioning

  has_many :mentioning_reports, through: :mentioning, source: :mentioning
  has_many :mentioned_reports, through: :mentioned, source: :mentioned

  validates :title, presence: true
  validates :content, presence: true

  after_save :mention

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
  private

  def mention
    keys = self.content.scan(%r{(?:http://localhost:3000/reports/)(\d+)}).flatten
    keys.each { |key| mentioning.create(mentioning_id: key) } unless keys.empty?
  end
end
