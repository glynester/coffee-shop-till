# require 'app'
require './lib/app.rb'

describe Shop do
  context 'Shop initialization and setup' do
    it 'initializes with a set format json file' do
      shop = Shop.new("./spec/test.json")
      expect(shop.shopname).to eq("Test Company")
    end

    it 'accepts a minimum spend level for a overall discount to be applied' do
      shop = Shop.new("./spec/test.json")
      expect(shop.general_discount(40)).to eq(40)
    end


    it 'accepts data to create a hash of items that are discounted' do
      shop = Shop.new("./spec/test.json")
      shop.make_discount_table("Cafe Latte",4,"1/1/2016","N/A")
      shop.make_discount_table("Americano",5,"15/11/2016","31/12/2016")
      shop.make_discount_table("Blueberry Muffin",6,"N/A","1/6/2017")
      data = shop.get_discount_data("Americano")
      expect(data[1].strftime('%a %d %b %Y')).to eq "Tue 15 Nov 2016"
    end

  end

  context 'Adding items to the basket of items' do
    it 'allows items to be added' do
      shop = Shop.new("./spec/test.json")
      shop.add_item("Blueberry Muffin",6)
      shop.add_item("Blueberry Muffin",6)
      expect(shop.basket[0]).to eq ["Blueberry Muffin", 6]
    end

  end



end
