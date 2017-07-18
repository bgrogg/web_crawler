require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'net/http'


# The object returned from HTTParty.get is an HTTParty::Response object
# containing the JSON that was returned from the site, along with its
# headers and other methods relating to the HTTP protocol, like the
# protocol version. HTTParty is that it automatically parses JSON and
# XML responses, based on the Content-Type of the response, so as soon as
# your response comes back it’s ready for you to work with it:

# this is how we request the page we're going to scrape
page = HTTParty.get('https://scottduane.github.io/TopSecretClue')

# this is where we transform our http response into a nokogiri object
parse_page = Nokogiri::HTML(page)

# this is an empty array where we will store all the links
links_array = []

parse_page.css('a').map do |link_obj|
  url = link_obj.values
  links_array.push(url)
  links_array.flatten!
end

links_array.each do |link|
  url = URI.parse(link)
  status_code = Net::HTTP.get_response(url).code

  if status_code != "404" 
    puts "#{status_code} ok - #{link}"
  else
    puts "#{status_code} link not working - #{link}"
  end

end

# Pry.start(binding)
