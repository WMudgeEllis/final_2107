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

  def bidded_items
    @items.find_all do |item|
      item.bids.length > 0
    end
  end

  def potential_revenue
    sum = 0
    bidded_items.each do |item|
      sum += item.current_high_bid
    end
    sum
  end

  def bidders
    arr = []
    bidded_items.each do |item|
      item.bids.each do |bidder, amount|
        arr << bidder.name
      end
    end
    arr.uniq
  end

  def bidder_obj
    bidded_items.flat_map do |item|
      item.bids.keys
    end.uniq
  end

  def object_by_bidder(bidder)
    bidded_items.find_all do |item|
      item.bidders.include?(bidder)
    end
  end

  def bidder_info
    h ={}
    bidder_obj.each do |bidder|
      h[bidder] = {:budget => bidder.budget, :items => object_by_bidder(bidder)}
    end
    h
  end
end
