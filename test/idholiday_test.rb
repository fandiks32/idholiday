require "test/unit"
require 'pp'

class IdHolidayTest <  Test::Unit::TestCase
  require File.expand_path(File.dirname(__FILE__) + "/../src/idholiday")

  test 'new' do
    # by default IdHoliday set year Time.now to attract with
    assert_equal Time.now.year, IdHoliday.new.year
    assert_equal Time.now.month, IdHoliday.new.month

    assert_equal 2020, IdHoliday.new(2020, 2).year
    assert_equal 2, IdHoliday.new(2020, 2).month

    assert_equal 1, IdHoliday.new(2021, 2).list.size
    assert_equal Date.new(2021, 2, 12), IdHoliday.new(2021, 2).list[0].date
    assert_equal "Tahun Baru Imlek", IdHoliday.new(2021, 2).list[0].name
    assert IdHoliday.new(2021, 2).list[0].confirmed
  end
end
