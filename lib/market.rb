class Market

  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    all_market_items = []
    @vendors.each do |vendor|
      vendor.all_items_in_stock.each do |item|
        all_market_items << item
      end
    end
    all_market_items.uniq.sort
  end

  def total_inventory
    inventory = Hash.new(0)

    sorted_item_list.each do |item|
      inventory[item] += 0
    end

    inventory.each do |item, amt|
      @vendors.each do |vendor|
        inventory[item] += vendor.check_stock(item)
      end
    end
    inventory
  end

  def sell(sell_item, sell_amt)
    check_inv = total_inventory.select do |item, amt|
      item == sell_item
    end

    return false if check_inv == {}
    return false if check_inv.values[0] < sell_amt

    vendors_that_have_item = vendors_that_sell(sell_item)

    sell_counter = 0
    vendors_that_have_item.each do |vendor|
      if sell_counter != sell_amt
        if vendor.check_stock(sell_item) >= sell_amt
          vendor.inventory[sell_item] -= sell_amt
          sell_counter += sell_amt
        else vendor.inventory[sell_item] -= vendor.check_stock(sell_item)
        end
      end
    end

    return true
  end

end
