# require "wanderlust/version"
require 'nokogiri'
require 'colorize'
require_relative '../lib/scraper.rb'
require_relative '../lib/destination.rb'

class CLI
  # index_url = "https://www.afar.com/travel-guides/all-travel-guides"

  def call
    puts "                "
    puts "·÷±‡± Welcome to Wanderlust ±‡±÷·".colorize(:blue)
    puts "                "
    continent_list
  end

  def continent_list
    puts "Which continent would you like to explore? (Enter number or exit)"
    puts "1. Africa"
    puts "2. Asia"
    puts "3. Europe"
    puts "4. North America"
    puts "5. Oceania"
    puts "6. South America"
    puts "                "
    which_continent?
  end

  def which_continent? # MAKE CASE STATEMENT FOR ALL OPTIONS
    user_input = gets.chomp
    if user_input == "exit"
      puts "See you on your next adventure!".colorize(:blue)
      exit
    elsif
      !user_input.to_i(>6)
      puts "Invalid entry. Please try again.".colorize(:red)
      destination_selector
    end
    display_details(user_input)
    list
  end

  def list
    puts "Available travel destinations around the world (in alphabetical order by location):".colorize(:cyan)
    make_destinations
    # add_attributes_to_destinations
    display_destinations
  end

  def make_destinations
    destinations_array = Scraper.scrape_destinations
    Destination.create_destination(destinations_array)
  end

  def add_attributes_to_destinations
    Destination.all.each do |destination|
      attributes = Scraper.scrape_destination_details(destination.url)
      destination.add_destination_attributes(attributes_hash)
    end
  end

  def display_destinations
    Destination.all.each.with_index(1) do |destination, i|
      puts "#{i}. #{destination.region_type} - #{destination.location}"
      end
    puts "                "
    destination_selector
  end

  def destination_selector
    puts "Which travel destination would you like to learn more about? (Enter a number or exit)".colorize(:cyan)
    user_input = gets.chomp
    if user_input == "exit"
      puts "See you on your next adventure!".colorize(:blue)
      exit
    elsif
      !user_input.to_i.between?(0, Destination.all.count)
      puts "Invalid entry. Please try again.".colorize(:red)
      destination_selector
    end
    display_details(user_input)
  end

  def display_details(user_input)
    destination = Destination.all[user_input.to_i-1]
    puts "                     "
    puts "Okay, let's explore the travel destination you picked in #{destination.location}.".colorize(:blue)
    puts "                     "
    puts ">>>>---------------- Your Essential #{destination.name} Travel Guide ----------------->"
    puts "                     "
    puts "The gist: "
    puts "#{destination.gist}"
    puts "                     "
    puts "When to visit: "
    puts "#{destination.time}"
    puts "                     "
    puts "Getting around: "
    puts "#{destination.transportation}"
    puts "                     "
    puts "Can't miss: "
    puts "#{destination.cant_miss}"
    puts "                     "
    puts "Food & drink: "
    puts "#{destination.food}"
    puts "                     "
    puts "Culture: "
    puts "#{destination.culture}"
    puts "                     "
    puts "What the locals know: "
    puts "#{destination.local_knowledge}"
    puts "                     "
    puts "Local resources: "
    puts "#{destination.resources}"
    puts "                     "
    puts "For more information on this travel destination, visit www.afar.com/travel-guides/#{destination.url}."
    puts "                     "
    list_again?
  end

  def list_again?
    puts "Would you like to return to the list of travel destinations in #{destination.region_type}? (Please enter yes or no)".colorize(:cyan)
    user_input = gets.chomp
    if user_input == "yes"
      puts "                     "
      list
    elsif user_input == "no"
      exit # INSTEAD OF EXIT ASK IF THEY WANT TO GO TO continent_list
    else
      puts "Sorry, I didn't understand that entry.".colorize(:red)
      list_again?
    end
  end

end
