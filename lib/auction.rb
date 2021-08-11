class Auction
  attr_reader :items, :date

  def initialize
    @items =[]
    @date =  Date.today.strftime("%d/%m/%Y")
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
    bidded_items.sum do |item|
      item.current_high_bid
    end
  end

  def bidders
    bidder_obj.map do |bidder|
      bidder.name
    end
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

  def sell

    bidder_info.each do |bidder, bid_info|
      require "pry"; binding.pry
      bid_info[:items].each do |arr|
        #ugh, oh well. needed to be a method any way, probably
        arr.each do |bidder, amount|

        end
      end
    end

  end


  def close_auction
    h = {}
    sell
    bidded_items.each do |item|
      h[item]
    end
    h ={}
  end
end
