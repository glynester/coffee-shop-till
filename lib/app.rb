require 'json'
require 'date'

class Shop

  attr_reader :shopname, :address, :phone, :prices, :basket, :total_owed,
  :receipt, :general_discount
  CONSUMER_TAX_RATE = 8.64

  def initialize(details_file)            # No need to check for duplicates in a hash
    file = File.read(details_file)
    data_hash = JSON.parse(file)          #Array of hash
    @shopname = data_hash[0]["shopName"]
    @address = data_hash[0]["address"]
    @phone = data_hash[0]["phone"]
    @prices = data_hash[0]["prices"]
    @discount_table = {}
    @basket = []
    @receipt = []
    @general_discount = 0
    @spend_amt_before_discount = 0
    @total_owed = 0
  end


  def set_general_discount(spend_amt, discount_percentage)
    @spend_amt_before_discount = spend_amt
    @general_discount = discount_percentage
  end

  def make_discount_table(discount_item, discount_percent, start_date = "N/A", end_date = "N/A")
    @discount_item = discount_item
    @discount_percent = discount_percent
    start_date == "N/A" ? start_date = start_date : start_date = Date.strptime(start_date,"%d/%m/%Y")
    end_date == "N/A" ? start_date = end_date : end_date = Date.strptime(end_date, "%d/%m/%Y")
    @discount_table[@discount_item] = [@discount_percent, start_date, end_date]
  end

  def get_discount_data(item)
    @discount_table[item]
  end

  def add_item(item, quantity)
    raise "\"#{item}\" is not sold at #{@shopname}" unless @prices[0].key?(item)
    @basket << [item, quantity]
  end

  def calculate_bill
    raise "No items in the basket" if @basket.empty?
    @basket.each{|item|
      description = item[0]
      price = @prices[0][item[0]]
      discounted_price = discount(description,price)
      discounted_price ? price = discounted_price : price = price
      quantity = item[1]
      @total_owed += (price * quantity).round(2)
      create_receipt(description,quantity,price)
    }
    @total_owed > @spend_amt_before_discount ?
    @total_owed -= (@total_owed * @general_discount/100.0).round(2) : @total_owed += 0
    @total_owed = (@total_owed + (@total_owed * CONSUMER_TAX_RATE/100.0)).round(2)
  end

  private
  def create_receipt(description,quantity,price)
    @receipt << [description, quantity, price]
  end

  def discount(description,price)
    #This needs to be expanded to see if it discount is still valid
    if get_discount_data(description)
      discount = @discount_table[description][0]
      return price = (price - (price * discount/100.0)).round(2)
    end
    return false
  end

end


















#
