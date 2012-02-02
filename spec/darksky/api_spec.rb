require 'spec_helper'

describe Darksky::API do
  let(:darksky_api) { Darksky::API.new('d41d8cd98f00b204e9800998ecf8427e') }

  describe '#forecast' do
    it 'should return a valid forecast for a latitude and longitude' do
      darksky_api.stub(:forecast).and_return(JSON.parse(%q(
      {
        "currentSummary":"Rain",
        "hourSummary":"Rain will stop in 25 minutes.",
        "station":"enx",
        
        "precipitation":[
            {"probability":1.0,
            "intensity":15.6,
            "stdev":1.0,
            "type":"rain",
            "time":1325607311},
            
            {"probability":0.84,
            "intensity":12.0,
            "stdev":2.34,
            "type":"rain",
            "time":1325607431},
            
            {"probability":0.8,
            "intensity":20.5,
            "stdev":5.1,
            "type":"rain",
            "time":1325607551}
          ]
        } 
      )))
      
      forecast = darksky_api.forecast('42.7243','-73.6927')
      forecast['currentSummary'].should == 'Rain'
      forecast['station'].should == 'enx'
    end
  end

  describe '#precipitation' do
    it 'should return forecasts for a collection of arbitrary points' do
      darksky_api.stub(:precipitation).and_return(JSON.parse(%q(
      {
        "precipitation":[
            {"probability":1.0,
            "intensity":15.6,
            "stdev":1.0,
            "type":"rain",
            "time":1325607100},
            
            {"probability":0.0,
            "intensity":0.0,
            "stdev":0.0,
            "type":"rain",
            "time":1325607791}
        ]
      }
      )))

      precipitation = darksky_api.precipitation(['42.7','-73.6',1325607100,'42.0','-73.0',1325607791])
      precipitation['precipitation'].size.should == 2
      precipitation['precipitation'].first['probability'].should == 1.0
      precipitation['precipitation'].first['type'].should == 'rain'
    end
  end
end