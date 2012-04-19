require_relative 'spec_helper'

configuration_root_dir = File.join(File.dirname(__FILE__),"..","fixtures")
YAML_FILENAME = "#{configuration_root_dir}/configuration.yml" unless defined? YAML_FILENAME

describe Configuration::YAML do
  
  let(:subject) { Configuration::YAML }
  
  describe "#parse" do
    
    let(:expected_result) do 
        # {"development"=>{ "host"=>"localhost:9090", 
        #   "title"=>"WIP Configuration Presentation"}, 
        #   "production"=>{ "host"=>"class-presentation.heroku.com",
        #     "title"=>"Configuration: The Final Frontier" } }
        Configuration.new 'host' => 'localhost:9090', 
          'title' => 'WIP Configuration Presentation'
          
      end
      
      let(:given_result) { subject.parse(YAML_FILENAME) }
      
    it "should accept a file and return a Configuration" do
      
      given_result.title.should eq(expected_result.title)
      given_result.host.should eq(expected_result.host)
      
    end
    
  end
end

describe Configuration do
  
  describe "Class Methods" do
    
    let(:subject) { Configuration }
    
    
    
    describe "#properties" do
      
      let(:given_results) { subject.properties.sort }
      let(:expected_results) { [ :title,:host, :port ].sort }
      
      it "should return the correct properties" do
        
        given_results.should == expected_results
        
      end
      

    end
    
  end
  
  
  describe "#merge" do
    
    let(:first_config) do
      Configuration.new 'host' => 'localhost:9090', 
        'title' => 'WIP Configuration Presentation'
    end
    
    let(:second_config) do
      Configuration.new 'host' => 'blacksheep:4567', 
              'title' => 'BAAAHHH!'
    end
    
    let(:given_result) { first_config.merge!(second_config) }

    it "should merge successfuly with another Configuration" do
      given_result.host.should == second_config.host
    end

  end
end

