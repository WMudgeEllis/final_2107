class Attendee
  attr_reader :name, :budget, :items

  def initialize(info)
    @name = info[:name]
    @budget = info[:budget].delete('$').to_i
    @items = []
  end

  def buy(item, bid)
    @items << item
    @budget -= bid
  end
end
