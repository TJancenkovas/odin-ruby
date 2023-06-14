require 'csv'
require 'google/apis/civicinfo_v2'

def clean_zipcode(zipcode)
  # if zipcode is 5 digits, assume OK
  # if zipcode is more than 5 digits, truncate  to first 5 digits.
  # if zipcode is less than 5 digits, pad it with 0 until it is 5
  # if zipcode missing (blank) replace it with 00000

  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name).join(', ')
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end
puts 'Event Manager Initialized!'

contents = CSV.open('../event_attendees.csv', headers: true, header_converters: :symbol)

contents.each do |line|
  name = line[:first_name]
  zipcode = clean_zipcode(line[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  puts "#{name}, #{zipcode}, #{legislators}"
end
