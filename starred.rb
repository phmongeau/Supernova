require 'rss'
require 'open-uri'

links = ""
refine = ""
linksH = {}

open( "http://www.google.com/reader/public/atom/user/13310254936429827125/state/com.google/starred?n=1000") do |http|
	response = http.read
	result = RSS::Parser.parse(response, false)
	items = result.items
	
	i = 0
	items.each do |item|
		links << item.link.href.to_s
		links << "\n"
		linksH[i.to_s << " - " << item.title.to_s.gsub('<title type="html">', '').gsub('</title>', '')] = item.link.href.to_s
		i += 1
	end
end

puts links.length
puts linksH.length

File::open( 'starred.txt', 'w') do |f|
	f << links
	#puts "write to file"
end

File::open( 'starred.html', 'w') do |f|
	f << "<html>\n<head>\n<title>Starred Items</title>\n</head>\n<body>\n"
	linksH.each do |title, link|
		f << "<a href='#{link}'>#{title}</a>"
		f << "<br> \n"
	end
	f << "</body>\n</html>"
end