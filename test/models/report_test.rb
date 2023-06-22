# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @report1 = reports(:one)
    @report2 = reports(:two)
    @report3 = reports(:three)
    @report_mention1 = report_mentions(:one)
  end

  test '#editable?' do
    assert @report1.editable?(@alice)
    assert_not @report1.editable?(@bob)
  end

  test '#created_on' do
    assert_equal Time.zone.today, @report1.created_on
  end

  test 'save_report' do
    assert_equal @report_mention1.mentioned_by_id, @report2.active_mentions[0].mentioned_by_id
    @report2.content ='http://localhost:3000/reports/113629430'
    @report2.save
    assert_not_equal  @report_mention1.mentioned_by_id, @report2.active_mentions[0].mentioned_by_id
    @report2.content = 'http://localhost:3000/reports/a'
    @report2.save
    assert_empty @report2.active_mentions
  end
end
