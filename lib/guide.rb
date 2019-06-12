class Guide
  
  require 'parser'
  
  def initialize(path=nil)
    Parser.filepath = path
    #if Parser.file_usable?
    #  puts "Found Webserver log file."
    #else
    #  puts "Exiting.\n\n"
    #  exit!
    #end
  end
  
  def launch!
    introduction
    # user action loop
    conclusion
  end
  
  def introduction
    puts "\n\n### Welcome to the Weblogs Statistics ###\n\n"
    puts "This is an interactive guide to help you find the statistics you need.\n\n"
  end
  
  def conclusion
    puts "\n\n### Goodbye, Thank you for you time ###\n\n"
  end
end