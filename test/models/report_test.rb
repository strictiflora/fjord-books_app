# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @report = reports(:alice_report)
  end

  test '#editable?' do
    assert @report.editable?(@alice)
  end

  test '#created_on' do
    assert_equal 'Thu, 16 Dec 2021'.to_date, @report.created_on
  end
end
