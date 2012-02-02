require 'spec_helper'

describe Darksky::API do
  let(:darksky_api) { Darksky::API.new('d41d8cd98f00b204e9800998ecf8427e') }

  describe '#forecast' do
    it 'should return a valid forecast for a latitude and longitude' do
      darksky_api.forecast('42.7243','-73.6927')
    end
  end

  describe '#precipitation' do
    it 'should return forecasts for a collection of arbitrary points' do
      darksky_api.precipitation(['42.7','-73.6',1325607100,'42.0','-73.0',1325607791])
    end
  end
end