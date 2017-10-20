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

    def save!    
      # TODO: Add validation before writing user data to file
      #return [] if File.file?("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json")
      order_a = []
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json")
      order_a = JSON.parse(file)

      order = {timestamp: @timestamp, origin: @origin, destination: @destination, est_price: @est_price}

      order_a << order

      File.open("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json", "w") do |f|
        f.write JSON.generate(order_a)
      end	
		end

    def self.view_history
      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/orders.json")
      data = JSON.parse(file)
      data
    end
	end
end