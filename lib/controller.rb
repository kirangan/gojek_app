require 'json'
require 'date'
require_relative './models/user'
require_relative './models/location'
require_relative './models/order'
require_relative './view'

module GoCLI
  # Controller is a class that call corresponding models and methods for every action
  class Controller
    # This is an example how to create a registration method for your controller
    def registration(opts = {})
      # First, we clear everything from the screen
      clear_screen(opts)

      # Second, we call our View and its class method called "registration"
      # Take a look at View class to see what this actually does
      form = View.registration(opts)

      # This is the main logic of this method:
      # - passing input form to an instance of User class (named "user")
      # - invoke ".save!" method to user object
      # TODO: enable saving name and email
      user = User.new(
        name: form[:name],
        email: form[:email],
        phone:    form[:phone],
        password: form[:password]

      )
      user.save!

      # Assigning form[:user] with user object
      form[:user] = user

      # Returning the form
      form
    end
    
    def login(opts = {})
      halt = false
      while !halt
        clear_screen(opts)
        form = View.login(opts)
        puts form

        # Check if user inputs the correct credentials in the login form
        if credential_match?(form[:user], form[:login], form[:password])
          halt = true
        else
          form[:flash_msg] = "Wrong login or password combination"
        end
      end

      return form
    end
    
    def main_menu(opts = {})
      clear_screen(opts)
      form = View.main_menu(opts)

      case form[:steps].last[:option].to_i
      when 1
        # Step 4.1
        view_profile(form)
      when 2
        # Step 4.2
        order_goride(form)
      when 3
        # Step 4.3
        view_order_history(form)
      when 4
        exit(true)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        main_menu(form)
      end
    end
    
    def view_profile(opts = {})
      clear_screen(opts)
      form = View.view_profile(opts)


      case form[:steps].last[:option].to_i
      when 1
        # Step 4.1.1
        edit_profile(form)
      when 2
        main_menu(form)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        view_profile(form)
      end
    end

    # TODO: Complete edit_profile method
    # This will be invoked when user choose Edit Profile menu in view_profile screen
    def edit_profile(opts = {})
      clear_screen(opts)
      form = View.edit_profile(opts)
     # puts form
      
      case form[:steps].last[:option].to_i
      when 1
        user = User.new(
        name: form[:name],
        email: form[:email],
        phone:    form[:phone],
        password: form[:password]
        )
        user.save!

        form[:user] = user
        view_profile(form)
        form
      when 2
        view_profile(form)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        edit_profile(form)
      end
    end

    # TODO: Complete order_goride method
    def order_goride(opts = {})
      clear_screen(opts)
      form = View.order_goride(opts)
      form[:location_data]=Location.location_data
      point_1 = Hash.new(0)
      point_2 = Hash.new(0)

      location_length = nil

      form[:location_data].each do |x|
        if x.rassoc(form[:start])
          point_1 = x
        end
        if x.rassoc(form[:finish])
          point_2 = x
        end
      end

      point_1_num = point_1.values[1]
      point_2_num = point_2.values[1]

      if (point_1.values == []) || (point_2.values == []) 
        form[:flash_msg] = "Sorry, the route is unavailable"
        order_goride(form)
      else
        location_length = Math.sqrt(((point_2_num[0] - point_1_num[0])**2) + ((point_2_num[1] - point_1_num[1])**2)).to_f
        form[:est_price] = (location_length * 1500).to_i
        form[:timestamp] = DateTime.now
        order_goride_confirm(form)
      end

      form

    end

    # TODO: Complete order_goride_confirm method
    # This will be invoked after user finishes inputting data in order_goride method

    def order_goride_confirm(opts)
      clear_screen(opts)  
      form = View.order_goride_confirm(opts)
      
      case form[:steps].last[:option].to_i
      when 1
        order = Order.new(
        timestamp: form[:timestamp],
        origin: form[:start],
        destination: form[:finish],
        est_price: form[:est_price]
        )
        order.save!

        form[:order] = order
        form[:flash_msg] = "Have a nice day!"
       # main_menu(form)
        form
      when 2
        order_goride(form)

      when 3
        main_menu(form)
      else 
        form[:flash_msg] = "Wrong option entered, please retry."
        order_goride_confirm(form)
      end
    end

    def view_order_history(opts = {})
      clear_screen(opts)
      form = View.view_order_history(opts)
      #form[:view_history]=Order.view_history
      
      case form[:steps].last[:option].to_i
      when 1
        main_menu(form)
      else
        form[:flash_msg] = "Wrong option entered, please retry."
        view_order_history(form)
      end

    end

    
    protected
      # You don't need to modify this 
      def clear_screen(opts = {})
        Gem.win_platform? ? (system "cls") : (system "clear")
        if opts[:flash_msg]
          puts opts[:flash_msg]
          puts ''
          opts[:flash_msg] = nil
        end
      end

      # TODO: credential matching with email or phone
      def credential_match?(user, login, password)
        return false unless user.phone == login || user.email == login
        return false unless user.password == password
        return true
      end
  end
end
