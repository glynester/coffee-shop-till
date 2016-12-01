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
    puts @prices
  end

end
