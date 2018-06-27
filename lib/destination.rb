# require "wanderlust/version"

class Destination
  attr_accessor :location, :gist, :time, :transportation, :cant_miss, :food, :culture, :local_knowledge, :resources, :url

  @@all = []

  def initialize(destination_hash)
    destination_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self unless @@all.any? {|destination| destination.location == self.location} #change to .url once scraper is working
  end

  def self.all
    @@all
  end

  def self.create_destination(destination_array)
    destination_array.each do |destination_hash|
      self.new(destination_hash)
    end
  end

  def add_destination_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    check_attributes_for_nil
    self
  end

  def check_attributes_for_nil
  attributes = ["location", "gist", "time", "transportation", "cant_miss", "food", "culture", "local_knowledge", "resources", "url"]
  empty = [" ", "", nil]
    attributes.each do |var|
      if empty.any? { |e| self.send("#{var}") == e}
        self.send(("#{var}="), "N/A")
      end
    end
  end

end
