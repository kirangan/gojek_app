require 'json'

module GoCLI
  class User
    attr_accessor :name, :email, :phone, :password

    # TODO: 
    # 1. Add two instance variables: name and email 
    # 2. Write all necessary changes, including in other files
    def initialize(opts = {})
      @name = opts[:name] || ''
      @email = opts[:email] || ''
      @phone = opts[:phone] || ''
      @password = opts[:password] || ''
    end

    def self.load
      return nil unless File.file?("#{File.expand_path(File.dirname(__FILE__))}/../../data/user.json")

      file = File.read("#{File.expand_path(File.dirname(__FILE__))}/../../data/user.json")
      data = JSON.parse(file)

      self.new(
        name: data['name'],
        email: data['email'],
        phone:    data['phone'],
        password: data['password']
      )
    end

    # TODO: Add your validation method here
    def validates
      temp = ""
      if (@name == '') || (@email == '') || (@phone == '') || (@password == '')
        temp = "false"
      else
        temp = "true"
      end
    end

    def save!
      # TODO: Add validation before writing user data to file
      user = {name: @name, email: @email, phone: @phone, password: @password}
      
        File.open("#{File.expand_path(File.dirname(__FILE__))}/../../data/user.json", "w") do |f|
          f.write JSON.generate(user)
        end
    end

  end
end
