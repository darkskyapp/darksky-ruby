require 'spec_helper'

describe Darksky::API do
  let(:darksky_api) { Darksky::API.new('this-is-your-dark-sky-api-key') }

  describe '#forecast' do
    it 'should return a valid forecast for a latitude and longitude' do
      VCR.use_cassette('forecast', :record => :once) do
        forecast = darksky_api.forecast('42.7243','-73.6927')
        forecast['currentSummary'].should == 'clear'
        forecast['radarStation'].should == 'enx'
      end
    end
  end

  describe '#brief_forecast' do
    it 'should return a valid brief forecast for a latitude and longitude' do
      VCR.use_cassette('brief_forecast', :record => :once) do
        forecast = darksky_api.brief_forecast('42.7243','-73.6927')
        forecast['currentSummary'].should == 'clear'
        forecast['hourSummary'].should == 'clear'
      end
    end
  end

  describe '#precipitation' do
    it 'should return forecasts for a collection of arbitrary points' do
      VCR.use_cassette('precipitation', :record => :once) do
        precipitation = darksky_api.precipitation(['42.7','-73.6',1325607100,'42.0','-73.0',1325607791])
        precipitation['precipitation'].size.should == 2
        precipitation['precipitation'].first['probability'].should == 0
        precipitation['precipitation'].first['type'].should == 'rain'
      end
    end
  end

  describe '#interesting' do
    it 'should return a list of interesting storms happening right now' do
      VCR.use_cassette('interesting', :record => :once) do
        interesting_storms = darksky_api.interesting
        interesting_storms.size.should == 1
      end
    end
  end

  describe '#create_notification' do
    it 'should return a notification ID on successfully creating a notification' do
      VCR.use_cassette('create_notification', :record => :once) do
        created_notification = darksky_api.create_notification(42.735, -73.6931, 'http://example.com/some/callback')
        created_notification['id'].should == 30713794
      end
    end
  end

  describe '#retrieve_notification' do
    it 'should return information about a notification that has been created' do
      VCR.use_cassette('retrieve_notification', :record => :once) do
        notification = darksky_api.retrieve_notification(30713794)
        notification['id'].should == 30713794
        notification['latitude'].should == 42.74
        notification['enabled'].should be_true
        notification['notificationCount'].should == 0
      end
    end
  end

  describe '#update_notification' do
    it 'should update a notification' do
      VCR.use_cassette('updated_notification', :record => :once) do
        updated_notification = darksky_api.update_notification(30713794, :enabled => 0)
        updated_notification.should == {}

        notification = darksky_api.retrieve_notification(30713794)
        notification['enabled'].should be_false
      end
    end
  end
end