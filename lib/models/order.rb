# TODO: Complete Order class
require 'json'

module GoCLI
	class Order 
		attr_accessor :timestamp, :origin, :destination, :est_price
		def initialize(opts = {})
			@timestamp = opts[:timestamp] || ''
			@origin = opts[:origin] || ''
			@destination = opts[:destination] || ''
			@est_price = opts[:est_price]
		end
		
		def self.add_order
      		

      		
		end
	end
end