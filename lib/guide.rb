class Guide
  
  require 'parser'
  require 'config'
  
  def initialize(path=nil)
    Parser.filepath = path
    if Parser.file_usable?
      puts "Found Webserver log file."
    else
      puts "Exiting.\n\n"
      exit!
    end
  end
  
  def launch!
    introduction
    # user action loop
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action(action, args)
    end
    conclusion
  end
  
  def get_action
    action = nil
    puts "\nUse one of the actions listed below to conitinue \n"
    puts "Actions: " + Config.actions.join(", ")
    print "> "
    user_response = gets.chomp
    args = user_response.downcase.strip.split(' ')
    action = args.shift
    return action, args
  end
  
  def do_action(action, args=[])
    case action
    when 'logs'
      list(args)
    when 'quit'
      return :quit
    else
      puts "\n That is an invalid action \n"
    end
  end
  
  def list(args=[])
    sort_order = args.shift
    sort_order = args.shift if sort_order == 'by'
    sort_order = "visits" unless ['visits', 'unique'].include?(sort_order)
    
    output_action_header("Listing Logs")
    
    logs = Parser.parse
    case sort_order
      when 'visits'
        sorted_logs = logs.sort_by{|key, value|-value.size}
      when 'unique'
        sorted_logs = logs.sort_by{|key, value|-value.uniq.size}
    end
    output_logs_table(sorted_logs)
    puts "\n ### Sort Actions ###\n\n"
    puts "Sort using action: 'logs unique' or 'logs by unique'\n\n"
    puts "or\n\n"
    puts "Sort using action: 'logs visits' or 'logs by visits'\n\n"
    puts "-" * 60
  end
  
  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_logs_table(logs=[])
    puts "-" * 60
    print " " + "Url".ljust(30)
    print " " + "Unique".ljust(10)
    print " " + "Visits".ljust(10)
    puts " "
    logs.each do |key, value|
      line =  " " << "#{key}".ljust(30)
      line << " " << "#{value.uniq.size}".ljust(10)
      line << " " + "#{value.size}".ljust(10)
      puts line
    end
    puts "No listings found" if logs.empty?
    puts "-" * 60
  end
  
  def introduction
    puts "\n\n### Welcome to the Weblogs Statistics ###\n\n"
    puts "This is an interactive guide to help you find the statistics you need.\n\n"
  end
  
  def conclusion
    puts "\n\n### Goodbye, Thank you for you time ###\n\n"
  end
end