require 'erb'
require 'rss'
require 'gmail'

############### TIME ###############
t = Time.now
string_date = t.strftime("%A %B %d, %Y")

if t.hour < 12
  hello_message = "Good Morning, Kate!"
elsif t.hour > 12 && t.hour < 17 
  hello_message = "Good Afternoon, Kate!"
else
  hello_message = "Good Evening, Kate!"
end

############### WEATHER FEED ###############
url = 'http://weather.yahooapis.com/forecastrss?w=12795711'
feed = RSS::Parser.parse(url, false)

data = ""
case feed.feed_type
	when 'rss'
		feed.items.each { |item| data = item.description }
	when 'atom'
		feed.items.each { |item| puts item.content }
end

arr = data.split("\n")

day = []
arr[5..9].each_with_index do |line, i|
	day[i] = Hash.new
	today = (line.split("-").last)[1..-7]
	day[i][:forecast] = today.split(".")[0]
	high_and_lows = today.split(".")[1].split(" ")
	day[i][:high] = high_and_lows[1]
	day[i][:low] = high_and_lows[3]
end

if (day[0][:forecast].downcase.include?("rain") || day[0][:forecast].downcase.include?("showers")) && (day[1][:forecast].downcase.include?("rain") || day[1][:forecast].downcase.include?("showers"))
	weather_message = "Close windows and bring stuff inside - it's going to rain today and tomorrow!"
elsif day[0][:forecast].downcase.include?("rain") || day[0][:forecast].downcase.include?("showers")
	weather_message = "Close windows and bring stuff inside - it's going to rain today!"
elsif day[1][:forecast].downcase.include?("rain") || day[1][:forecast].downcase.include?("showers")
	weather_message = "Close windows and bring stuff inside tonight - it's going to rain tomorrow."
end

############### GENERATE INDEX ###############
@path = "./"
def create_index(index_page)
	filename = "#{@path}/index.html"
	File.open(filename, 'w') do |file|
		file.puts index_page
	end
end

index_template = File.read "#{@path}/erb_templates/index_template.erb"
erb_template_index = ERB.new index_template
index_page = erb_template_index.result(binding)
create_index(index_page)

system("open #{@path}/index.html")
