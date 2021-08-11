require "./lib/attendee"
require './lib/item'


RSpec.describe Attendee do

  it 'can pass iteration 1' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    attendee = Attendee.new(name: 'Megan', budget: '$50')

    expect(attendee.name).to eq("Megan")
    expect(attendee.budget).to eq(50)
  end

  it 'can buy an object' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee = Attendee.new(name: 'Megan', budget: '$50')

    attendee.buy(item1, 30)

    expect(attendee.budget).to eq(20)
    expect(attendee.items).to eq([item1])
  end


end
