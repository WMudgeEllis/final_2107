class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @open = true
  end

  def add_bid(attendee, amount)
    @bids[attendee] = amount if @open == true
  end

  def current_high_bid
    @bids.values.max
  end

  def close_bidding
    @open = false
  end

  def bidders
    @bids.keys
  end
end
