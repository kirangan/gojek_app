module GoCLI
  # View is a class that show menus and forms to the screen
  class View
    # This is a class method called ".registration"
    # It receives one argument, opts with default value of empty hash
    # TODO: prompt user to input name and email
    def self.registration(opts = {})
      form = opts

      puts 'Registration'
      puts ''

      print 'Your name: '
      form[:name] = gets.chomp

      print 'Your email: '
      form[:email] = gets.chomp

      print 'Your phone: '
      form[:phone] = gets.chomp

      print 'Your password: '
      form[:password] = gets.chomp

      form[:steps] << {id: __method__}

      form
    end

    def self.login(opts = {})
      form = opts

      puts 'Login'
      puts ''

      print 'Enter your login: '
      form[:login] = gets.chomp

      print 'Enter your password: '
      form[:password] = gets.chomp

      form[:steps] << {id: __method__}

      form
    end

    def self.main_menu(opts = {})
      form = opts

      puts 'Welcome to Go-CLI!'
      puts ''

      puts 'Main Menu'
      puts '1. View Profile'
      puts '2. Order Go-Ride'
      puts '3. View Order History'
      puts '4. Exit'
      puts ''
      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}

      form
    end

    # TODO: Complete view_profile method
    def self.view_profile(opts = {})
      form = opts

      puts 'View Profile'
      puts ''

      # Show user data here
      puts "Name: #{form[:user].name}"
      puts "Email: #{form[:user].email}"
      puts "Phone: #{form[:user].phone}"
      puts "Password: #{form[:user].password}"
      puts ''
      puts '1. Edit Profile'
      puts '2. Back'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}

      form
    end

    # TODO: Complete edit_profile method
    # This is invoked if user chooses Edit Profile menu when viewing profile
    def self.edit_profile(opts = {})
      form = opts
      
      puts 'Edit Profile'
      puts ''

      # Show edit profile
      puts 'New name: '
      form[:name] = gets.chomp
      puts 'New email: '
      form[:email] = gets.chomp
      puts 'New phone: '
      form[:phone] = gets.chomp
      puts 'New password: '
      form[:password] = gets.chomp

      puts '1. Save'
      puts '2. Cancel'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}
      form
    end

    # TODO: Complete order_goride method
    def self.order_goride(opts = {})
      form = opts
      
      puts 'Order Go-Ride'
      puts ''

      puts 'From: '
      form[:start] = gets.chomp
      puts 'Where: '
      form[:finish] = gets.chomp

      form[:steps] << {id: __method__}
      form
      
    end

    # TODO: Complete order_goride_confirm method
    # This is invoked after user finishes inputting data in order_goride method
    def self.order_goride_confirm(opts = {})
      form = opts
      
      puts 'Confirm order Go-Ride'

      puts "Timestamp: #{form[:timestamp]}"
      puts "Origin: #{form[:start]}"
      puts "Destination: #{form[:finish]}"
      puts "Price: #{form[:est_price]}"
      puts ''

      puts '1. Order'
      puts '2. Repeat'
      puts '3. Back to the main menu'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}
      form
    end

    # TODO: Complete view_order_history method
    def self.view_order_history(opts = {})
      form = opts
      puts 'History'
      puts ''
      puts "Timestamp: #{form[:order].timestamp}"
      puts "Origin: #{form[:order].origin}"
      puts "Destination: #{form[:order].destination}"
      puts "Price: #{form[:order].est_price}"
      puts ''
      
      puts '1. Back'

      print 'Enter your option: '
      form[:steps] << {id: __method__, option: gets.chomp}
      form
    end
  end
end
