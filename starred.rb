require 'rss'
require 'open-uri'

links = ""
refine = ""

open( "http://www.google.com/reader/public/atom/user/13310254936429827125/state/com.google/starred?n=1000") do |http|
	response = http.read
	result = RSS::Parser.parse(response, false)
	items = result.items
	
	items.each do |item|
		puts item.link.href
		links << item.link.href.to_s
		links << "\n"
	end
end

File::open( 'starred.txt', 'w') do |f|
	f << links
	puts "write to file"
end