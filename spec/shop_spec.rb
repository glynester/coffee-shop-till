# require 'app'
require './lib/app.rb'

describe Shop do
  context 'Shop initialization' do
    it 'initializes with a set format json file' do
      shop = Shop.new("./spec/test.json")
      expect(shop.shopname).to eq("Test Company")
    end

    it 'accepts a minimum spend level for a overall discount to be applied' do
      shop = Shop.new("./spec/test.json")
      expect(shop.general_discount(40)).to eq(40)
    end

  end




end
