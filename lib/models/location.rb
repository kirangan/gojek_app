# TODO: Complete Location class
require 'json'

module GoCLI
  class Location
    attr_accessor :name, :coord
    def initialize(opts = {})
      @name = opts[:name] || ''
      @coord = opts[:coord] || ''
    end

    def self.location_data
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/locations.json")
      data = JSON.parse(file)
      data
    end
    
  end
end