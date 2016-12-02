require 'json'
require 'date'

class Shop

  attr_reader :shopname, :address, :phone, :prices, :basket

  def initialize(details_file)
    file = File.read(details_file)
    data_hash = JSON.parse(file)
    @shopname = data_hash[0]["shopName"]  #Array of hash
    @address = data_hash[0]["address"]    #Array of hash
    @phone = data_hash[0]["phone"]        #Array of hash
    @prices = data_hash[0]["prices"]      #Array of hash
    @discount_table = {}
    @basket = []
  end


  def general_discount(spend_amt)
    @spend_amt_before_discount = spend_amt
  end

  def make_discount_table(discount_item, discount_percent, start_date = "N/A", end_date = "N/A")
    @discount_item = discount_item
    @discount_percent = discount_percent
    start_date == "N/A" ? start_date = start_date : start_date = Date.strptime(start_date,"%d/%m/%Y")
    end_date == "N/A" ? start_date = end_date : end_date = Date.strptime(end_date, "%d/%m/%Y")
    # @discount_period = [start_date, end_date]
    @discount_table[@discount_item] = [@discount_percent, start_date, end_date]
  end

  def get_discount_data(item)
    @discount_table[item]
  end

  def add_item(item, quantity)
    raise "\"#{item}\" is not sold at #{@shopname}" unless @prices[0].key?(item)
    @basket << [item, quantity]
  end

end


















#
