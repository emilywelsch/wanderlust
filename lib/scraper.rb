# require "wanderlust/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/destination.rb'


class Scraper

  def self.scrape_destinations
    destinations = [{:name=>"Inca destination", :location=>"Peru", :distance=>"26 miles", :time=>"4 days", :best_time=>"May to September", :description=>"One of the most popular hikes in the world, the Inca destination takes you through 26 miles of grueling inclines and declines. You get a chance to explore ruins, jungle, and beautiful mountain scenery, and of course, end the hike at Machu Picchu.", :url=>"/25-best-hikes-in-the-world-bucket-list/", :tips=>"Have fun!"}]
    # destinations = []
    # doc = Nokogiri::HTML(open("https://www.afar.com/travel-guides/all-travel-guides"))
    #   doc.css('div._e296pg').each do |heading|
    #     # binding.pry
    #     destination_info = {}
    #     destination_info[:name] = heading.css('div._18nb9p').text
    #     destination_info[:location] = heading.css('div._1uel1v2').text
    #     destination_info[:distance] = heading.css('div._vpdeeg').text
    #     destination_info[:time] = heading.css('span._q27mtmr').text
    #     destination_info[:best_time] = heading.css('span._1m8bb6v').text
    #     destination_info[:description] = heading.css('span._1m8bb6v').text
    #     destination_info[:url] = heading.css('a').attr("href").value
    #     destinations << destination_info # Can I use sort_by on destination_info to alphabetize hashes?
    #   end
    destinations
  end

  def self.scrape_destination_details(profile_url)
    destination_profile = "https://www.afar.com/travel-guides/all-travel-guides" + profile_url
    destination_profile_page = Nokogiri::HTML(open(destination_profile))

        destination_profile_details = []
        destinations_page.css("").each do |attribute|
            tips = attribute.css('div._n5wk6ic').text
            destination_profile_details << {tips: tips}
          end
        destination_profile_details
  end


end
