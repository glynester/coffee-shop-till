require 'json'

class Shop

  attr_reader :shopname, :address, :phone, :prices

  def initialize(details_file)
    file = File.read(details_file)
    data_hash = JSON.parse(file)
    @shopname = data_hash[0]["shopName"]  #Array of hash
    @address = data_hash[0]["address"]    #Array of hash
    @phone = data_hash[0]["phone"]        #Array of hash
    @prices = data_hash[0]["prices"]      #Array of hash
    # @discount_item = ""
    # @discount_period = [@start_date, @end_date]
    # @discount_table = [@discount_item, @discount_period]
    # @spend_amt_before_discount
  end

  def general_discount(spend_amt)
    @spend_amt_before_discount = spend_amt
  end

  def make_discount_table(discount_item, start_date = "N/A", end_date = "N/A")
    @discount_item = discount_item
    # start_date != "N/A"
    @discount_period = [start_date, end_date]
    @discount_table = [@discount_item, @discount_period]
  end

end

class Till
  def initialize

  end

end
