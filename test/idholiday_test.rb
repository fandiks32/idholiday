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
  end

  test 'list' do
    assert_equal 1, IdHoliday.new(2021, 2).list.size
    assert_equal Date.new(2021, 2, 12), IdHoliday.new(2021, 2).list[0].date
    assert_equal "Tahun Baru Imlek", IdHoliday.new(2021, 2).list[0].name
    assert IdHoliday.new(2021, 2).list[0].confirmed
  end

  test 'check' do
    assert IdHoliday.check(Date.new(2020, 1, 1))
    assert IdHoliday.check(Date.new(2020, 5, 10))
    assert_not IdHoliday.check(Date.new(2020, 1, 23))
  end

  test 'name' do
    assert_equal 'Tahun Baru Masehi', IdHoliday.name(Date.new(2020, 1, 1))
    assert_equal 'Independent Day', IdHoliday.name(Date.new(2020, 7, 17))
    assert_nil IdHoliday.name(Date.new(2020, 7, 14)) # Not holiday
  end

  test 'between' do
    assert_equal 13, IdHoliday.between(Date.new(2020, 1, 1), Date.new(2020, 5, 31)).size
    assert_raise(ArgumentError) {
      IdHoliday.between(nil, Date.new(2020, 5, 31))
      IdHoliday.between(Date.new(2020, 5, 31), nil)
      IdHoliday.between(nil, nil)
      IdHoliday.between(Date.new(2021, 5, 31), Date.new(2020, 5, 31))
    }
  end
end
