# require 'app'
require './lib/app.rb'

describe Shop do
  context 'Shop initialization' do
    it 'initializes with a json file' do
      shop = Shop.new("./spec/test.json")
      expect(shop.shopname).to eq("Test Company")
    end

  end
end
