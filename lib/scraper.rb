# require "wanderlust/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/destination.rb'


class Scraper

  def self.scrape_destinations
    # set this up so all locations go into continent and then continent goes into continents
    # destinations = [{:location=>"Amsterdam", :gist=>"A paragraph of information.", :time=>"A paragraph of information.", :transportation=>"A paragraph of information.", :cant_miss=>"A paragraph of information.", :food=>"A paragraph of information.", :culture=>"A paragraph of information.", :local_knowledge=>"A paragraph of information.", :resources=>"A paragraph of information.", :url=>"/the-netherlands/amsterdam/guide"}]
    destinations = []
    doc = Nokogiri::HTML(open("https://www.afar.com/travel-guides/all-travel-guides"))
      doc.css('li.content-container').each do |location|
        binding.pry
        destination_info = {}
        destination_info[:location] = location.css('a').attr("data-google-label").text
        # destination_info[:location] = location.css('div._1uel1v2').text
        destination_info[:url] = location.css('a').attr("href").value
        destinations << destination_info # Can I use sort_by on destination_info to alphabetize hashes?
      end
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
