require 'nokogiri'
require 'open-uri'
require 'set'

# Fetch and parse HTML document
def arachnid(url, visited = Set.new)

  doc = Nokogiri::HTML(open(url))

  links = []

  doc.css('a').each do |link|
    begin
      test = Nokogiri::HTML(open(link["href"]))
      links.push(link["href"]) unless visited.include?(link)
      visited.add(link["href"])
      p visited
    rescue
    end
  end



  links.each do |link|
    arachnid(link, visited)
  end

  visited
end
