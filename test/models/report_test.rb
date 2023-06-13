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

  test "#editable?" do
    assert @report1.editable?(@alice)
    assert_not @report1.editable?(@bob)
  end

  test "#created_on" do
    assert_equal '2023-06-13'.to_date, @report1.created_on
    @report2.created_at = "test"
    assert_raises('NoMethod'){@report2.created_on}
  end

  test "#save_mentions" do
    assert_equal @report1, @report2.mentioning_reports.first
    @report2.content = "http://localhost:3000/reports/113629430"
    @report2.send(:save_mentions)
    assert_equal @report3, @report2.mentioning_reports.second
  end
end
