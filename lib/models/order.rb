# TODO: Complete Order class
require 'json'

module GoCLI
	class Order 
		attr_accessor :timestamp, :origin, :destination, :est_price
		

    def initialize(opts = {})
			@timestamp = opts[:timestamp] || ''
			@origin = opts[:origin] || ''
			@destination = opts[:destination] || ''
			@est_price = opts[:est_price] || ''
     
		end
		
		def self.add_order
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json")
      data = JSON.parse(file)

      self.new(
        timestamp: data['timestamp'],
        origin: data['origin'],
        destination: data['destination'],
        est_price: data['est_price']
      )
    end	

    def self.view_order
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json")
      data = JSON.parse(file)
      data
    end	

    def save!
    
      # TODO: Add validation before writing user data to file
      order = {timestamp: @timestamp, origin: @origin, destination: @destination, est_price: @est_price}
      File.open("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json", "a") do |f|
        f.write JSON.generate(order)
      end

      		
		end
	end
end