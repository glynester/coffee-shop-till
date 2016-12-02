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
      shop.set_general_discount(40,5)
      expect(shop.general_discount).to eq(5)
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
      shop.add_item("Americano",4)
      expect(shop.basket[0]).to eq ["Blueberry Muffin", 6]
    end

    it 'does not allow items to be added that are not sold' do
      shop = Shop.new("./spec/test.json")
      expect{shop.add_item("Blackberry Pie",6)}.to raise_error("\"Blackberry Pie\" is not sold at Test Company")
    end
  end

  context 'Added items appear in the receipt log' do
    it 'throws an error if the basket is empty' do
      shop = Shop.new("./spec/test.json")
      expect{shop.calculate_bill}.to raise_error("No items in the basket")
    end

    it 'shows the added item purchased details in the receipt log and updates the total cost' do
      shop = Shop.new("./spec/test.json")
      shop.add_item("Blueberry Muffin",6)
      shop.add_item("Tea",4)
      shop.add_item("Affogato",2)
      shop.calculate_bill
      expect(shop.receipt[1]).to eq(["Tea", 4, 3.65])
      expect(shop.total_owed).to eq(74.42)
    end
  end

  context 'Finalise the bill' do
      it 'correctly calculates individual item discount (no start date but end date for discount period)' do
        shop = Shop.new("./spec/test.json")
        shop.make_discount_table("Cafe Latte",4,"1/1/2016","N/A")
        shop.make_discount_table("Americano",5,"15/11/2016","31/12/2016")
        shop.make_discount_table("Blueberry Muffin",6,"N/A","1/6/2017")
        shop.add_item("Blueberry Muffin",6)
        shop.add_item("Tea",4)
        shop.add_item("Affogato",2)
        shop.calculate_bill
        expect(shop.receipt[0]).to eq(["Blueberry Muffin", 6, 3.81])
        expect(shop.total_owed).to eq(72.85)
      end

      it 'individual item discount throws error (no start date but end date for discount period has passed)' do
        shop = Shop.new("./spec/test.json")
        shop.make_discount_table("Blueberry Muffin",6,"N/A","1/6/2016") #Past date
        shop.add_item("Blueberry Muffin",6)
        shop.calculate_bill
        expect(shop.receipt[0]).to eq(["Blueberry Muffin", 6, 4.05])
        expect(shop.total_owed).to eq(26.4)
      end

      #Test still required :
      # 1) Start date must be before end date.
      # 2) start date and end date (valid)
      # 3) start date and end date (end date is passed)(start date has not been reached)
      # 4) start date but no end date (valid)
      # 5) start date but no end date (date us before start date)
      # 6) no start date and no end date (all are valid)

      it 'correctly calculates overall spend discount' do
        shop = Shop.new("./spec/test.json")
        shop.set_general_discount(50,5)    # Discount is 5%
        shop.add_item("Blueberry Muffin",6)
        shop.add_item("Tea",4)
        shop.add_item("Affogato",2)
        shop.calculate_bill
        expect(shop.total_owed).to eq(70.69)
      end

      it 'correctly calculates the tax to be paid' do
        shop = Shop.new("./spec/test.json")
        shop.add_item("Blueberry Muffin",6)
        shop.calculate_bill
        expect(shop.total_owed).to eq(26.4)
      end
  end


end











#
