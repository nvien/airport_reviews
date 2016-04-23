require 'open-uri'
require 'nokogiri'
require 'pry'
require 'csv'

url ="https://www.world-airport-codes.com/us-top-40-airports.html"

page = Nokogiri::HTML(open(url))

#store data in an array
airport_names = []
page.css("tr th a[href]").each do |line|
  airport_names << line.text
end

# airport_websites = []
# page.css("tr th a[href]").each do |line|
#   airport_websites << line["href"]
# end


#details array includes other elements besides city names
details = []
page.css("tr td").each do |line|
  details << line.text.strip
  details.delete_if {|x| x == ""}
end

#To extract city names into cities array from details array
cities = []
(0...details.size).step(5).each do |index|
  cities << details[index]
end

iatas = []
(1...details.size+1).step(5).each do |index|
  iatas << details[index]
end


# Write data to CSV file
CSV.open("airport_listings.csv", "w") do |file|
  file << ["Airport Name", "City", "IATA"]

  airport_names.length.times do |i|
    file << [airport_names[i], cities[i], iatas[i]]
  end
end
