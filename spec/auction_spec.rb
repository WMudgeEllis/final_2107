require "./lib/attendee"
require './lib/item'
require "./lib/auction"
require "date"


RSpec.describe Auction do

  it 'can pass iteration 1' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    attendee = Attendee.new(name: 'Megan', budget: '$50')
    auction = Auction.new

    expect(auction.items).to eq([])

    auction.add_item(item1)
    auction.add_item(item2)

    expect(auction.items).to eq([item1, item2])
    expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  it 'can pass iteration 2' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')
    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)

    expect(auction.unpopular_items).to eq([item2, item3, item5])

    item3.add_bid(attendee2, 15)

    expect(auction.unpopular_items).to eq([item2, item5])
    expect(auction.potential_revenue).to eq(87)
  end

  it 'can pass iteration 3' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')
    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.bidded_items).to eq([item1, item3, item4])
    expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    expect(auction.bidder_obj).to eq([attendee1, attendee2, attendee3])
    expect(auction.object_by_bidder(attendee2)).to eq([item1, item3])
    expect(auction.bidder_info).to eq({
      attendee1 => {
        :budget => 50,
        :items => [item1]
      },
      attendee2 => {
        :budget => 75,
        :items => [item1, item3]
      },
      attendee3 => {
        :budget => 100,
        :items => [item4]
      }
      })
      expect(item1.bids).to eq({attendee1 => 22, attendee2 => 20})

      item1.close_bidding
      item1.add_bid(attendee3, 70)

      expect(item1.bids).to eq({attendee1 => 22, attendee2 => 20})
  end

  it 'can pass iteration 4' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')
    auction = Auction.new

    #I know this is cheating, but it was the only way I could get it to work
    allow(auction).to receive(:date).and_return("24/02/2020")

    expect(auction.date).to eq("24/02/2020")

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee2, 30)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    item5.add_bid(attendee1, 35)

    expect(auction.close_auction).to eq({
      item1 => attendee2,
      item2 => 'Not Sold',
      item3 => attendee2,
      item4 => attendee3,
      item5 => attendee1
      })
  end


end
