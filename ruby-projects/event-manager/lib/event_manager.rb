require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  # if zipcode is 5 digits, assume OK
  # if zipcode is more than 5 digits, truncate  to first 5 digits.
  # if zipcode is less than 5 digits, pad it with 0 until it is 5
  # if zipcode missing (blank) replace it with 00000

  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phonenumber(number)
  number = number.to_a
  count = number.chars.reduce(0) { |sum, el| integer?(el) ? (sum + 1) : sum }

  if count == 10
    number
  elsif count == 11 && number[0] = 1
    number[1..]
  else
    "Bad number"
  end
end

def get_registration_hour(date)
  Time.strptime(date, '%m/%d/%Y %k:%M').hour
end

def get_registration_wday(date)
  Date.strptime(date, '%m/%d/%Y %k:%M').strftime('%A')
end

def integer?(value)
  value == value.to_i.to_s
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, personal_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename  = "output/#{id}_formletter.html"

  File.open(filename, 'w') do |file|
    file.puts personal_letter
  end
end

def get_popular_hours(contents)
  hour_freq = contents.reduce(Hash.new(0)) do |hours, line|
    hour = get_registration_hour(line[:regdate])
    hours[hour] += 1
    hours
  end
  contents.rewind
  hour_freq.sort_by { |_, value| -value }.to_h
end

def get_popular_weekdays(contents)
  wday_freq = contents.reduce(Hash.new(0)) do |wdays, line|
    wday = get_registration_wday(line[:regdate])
    wdays[wday] += 1
    wdays
  end
  contents.rewind
  wday_freq.sort_by { |_, value| -value }.to_h
end
puts 'Event Manager Initialized!'

contents = CSV.open('/home/pasta/repos/odin-ruby/ruby-projects/event-manager/event_attendees.csv', headers: true, header_converters: :symbol)
template_letter = File.read('/home/pasta/repos/odin-ruby/ruby-projects/event-manager/form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |line|
  name = line[:first_name]
  zipcode = clean_zipcode(line[:zipcode])
  id = line[0]

  legislators = legislators_by_zipcode(zipcode)

  personal_letter = erb_template.result(binding)
  save_thank_you_letter(id, personal_letter)
  print id
end

contents.rewind

puts
puts get_popular_hours(contents)
puts get_popular_weekdays(contents)
