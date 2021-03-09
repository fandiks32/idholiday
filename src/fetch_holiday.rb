
lang    = 'id'
country = 'indonesian'
api_key = File.read(File.dirname(__FILE__) + '/../secret/apikey')

puts `curl -H 'Content-Type: application/json' -H 'Accept: application/json' https://www.googleapis.com/calendar/v3/calendars/#{lang}.#{country}%23holiday%40group.v.calendar.google.com/events?key=#{api_key}`
