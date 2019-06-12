class Parser
  
  @@filepath = nil
  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end
  def self.filepath
    @@filepath 
  end
  
  attr_accessor :url, :ip
  
  def self.file_exists?
    # check if file exists
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end
  
  def self.file_usable?
    #check if file has read and write permissions
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end
  
  # Depreciated
  def self.create_file
    # create the weblogs file if not found
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end
  
  def self.parse
    # Read log file and return a hash with format {:'url'=>[*'ips']}
    logs = {}
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        url, ip = line.split(' ')
        if logs[:"#{url}"].nil?
          logs[:"#{url}"] =[ip]
        else
          logs[:"#{url}"] << ip
        end
      end
      file.close
    end
    logs
  end
  
  def import_line(line)
    line_array = line.split(" ")
    @url, @ip = line_array
    return self
  end
  
end