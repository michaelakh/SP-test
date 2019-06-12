class Parser
  
  @@filepath = nil
  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end
  
  attr_accessor :url, :ip
  def self.file_usable?
    # check if file exists, and can be written to and read from
  end
  
  def self.parse
    # Read log file and return a hash with format {:'url'=>[*'ips']}
  end
end