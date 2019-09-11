class Vendor

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

  def all_items_in_stock
    items = []
    @inventory.each do |item, _|
      items << item
    end
    items
  end

end
