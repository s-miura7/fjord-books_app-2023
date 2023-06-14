# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @report1 = reports(:one)
    @report2 = reports(:two)
    @report3 = reports(:three)
  end

  test '#editable?' do
    assert @report1.editable?(@alice)
    assert_not @report1.editable?(@bob)
  end

  test '#created_on' do
    assert_equal Time.zone.today.to_date, @report1.created_on
    @report2.created_at = 'test'
    assert_raises('NoMethod') { @report2.created_on }
  end

  test '#save_mentions' do
    @report2.send(:save_mentions)
    assert_equal @report2.mentioning_reports.first.id, @report2.active_mentions.first.mentioned_by_id
    assert_equal @report1, @report2.mentioning_reports.first
    @report2.content = 'http://localhost:3000/reports/113629430'
    @report2.send(:save_mentions)
    assert_equal @report2.mentioning_reports.second.id, @report2.active_mentions.first.mentioned_by_id
    @report2.content = 'http://localhost:3000/reports/113629430 http://localhost:3000/reports/113629430'
    @report2.send(:save_mentions)
    assert_equal 1, @report2.active_mentions.length
    @report2.content = 'http://localhost:3000/reports/a'
    @report2.send(:save_mentions)
    assert_empty @report2.active_mentions
  end
end
