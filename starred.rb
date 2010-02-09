require 'rss'
require 'open-uri'

links = "" #raw link
linksH = [] #title and link for html

#open the rss and get the items
open( "http://www.google.com/reader/public/atom/user/13310254936429827125/state/com.google/starred?n=1000") do |http|
	response = http.read
	result = RSS::Parser.parse(response, false)
	items = result.items
	
	items.each do |item|
		links << item.link.href.to_s << "\n"
		linksH << [item.title.to_s.gsub('<title type="html">', '').gsub('</title>', ''), item.link.href.to_s]
	end
end


#writing the raw links file
File::open( 'starred.txt', 'w') do |f|
	f << links
end

#writing the html file
File::open( 'starred.html', 'w') do |f|
	f << "<html>\n<head>\n<title>Starred Items</title>\n</head>\n<body>\n"
	linksH.each do |item|
		f << "<a href='#{item[1]}'>#{item[0]}</a><br>\n"
	end
	f << "</body>\n</html>"
end