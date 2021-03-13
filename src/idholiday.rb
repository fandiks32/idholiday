require 'json'
require 'Date'

class IdHoliday
  attr_reader :year, :month
  
  def initialize(year = Time.now.year, month = Time.now.month)
    @year = year
    @month = month
  end

  def list
    @holidays ||= HolidayParser.parse.select { |holiday| holiday.date.year == @year && holiday.date.month == @month }
    @holidays
  end

  module HolidayParser
    module_function

    # TODO: parse passfilename
    def parse
      file         = File.read(File.expand_path(File.dirname(__FILE__) + "/../result/id.json"))
      hash_holiday = JSON.parse(file, symbolize_names: true)
      hash_holiday[:items].map do |item|
        Holiday.new(
          Date.parse(item[:start][:date]),
          item[:summary],
          item[:status] == 'confirmed'
        )
      end
    end
  end

  class Holiday
    attr_reader :date, :name, :confirmed
    
    def initialize(date, name, confirmed)
      @date = date
      @name = name
      @confirmed = confirmed
    end
  end
end
