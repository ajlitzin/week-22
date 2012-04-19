require 'YAML'


class Configuration
  
  def self.property(name,options = {})
    attr_accessor name
    @properties = [] unless @properties
    @properties << name
  end
  
  def self.properties
    @properties
  end
  
  property :host, :type => TrueClass
  property :title
  property :port
  
  
  def initialize(params = {})
    
    params.each do |key,value|
      @@properties
      if self.class.properties.include?(key.to_sym)
        send "#{key}=", value
      end
    end
    
  end

  def merge!(other_configuration)
    
    self.class.properties.each do |property|
      send "#{property}=", other_configuration.send(property)
    end
    
    self
  end
  
end


class Configuration
  
  class YAML
    
    def self.parse(filename)
      
      # Opening a file and parsing it YAML
      file_contents = File.read filename
      
      config_data = ::YAML::load file_contents
      
      config_sanctioned_hash = translate_yaml_config(config_data)
      
      # Creating a configuration to return
      
      Configuration.new config_sanctioned_hash
      
    end
    
    def self.translate_yaml_config(config_data)
      { 
        'title' => config_data['development']['title'],
        'host' => config_data['development']['host'] 
      }
    end

  end
  
end


# An example of dealing with arguments in pairs

# Remove the dash `-` from all the even parameters
# 
# @example ruby lib/command.rb -key value -key2 value2
# 
#     [ 'key', 'value', 'key2', 'value2' ] 
# 
# parameters = ARGV.each_with_index.map {|arg,index| (index % 2 == 0 and arg.start_with?("-")) ? arg[1..-1] : arg }
# puts ARGV
#
# puts Hash[*parameters]
#
# { 'a' => 'development/production', 'h' => 'hostname', 't' => 'title' }

