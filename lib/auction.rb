class Auction
  attr_reader :items

  def initialize
    @items =[]
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids == {}
    end
  end


  def potential_revenue
    sum = 0
    @items.each do |item|
      sum += item.current_high_bid if !unpopular_items.include?(item)
    end
    sum
  end
end
