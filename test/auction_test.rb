require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'pry'

class AuctionTest < Minitest::Test
  def test_it_exists
    auction = Auction.new

    assert_instance_of Auction, auction
  end

  def test_it_has_readable_attributes
    auction = Auction.new

    assert_equal [], auction.items
  end

  def test_add_item
    auction = Auction.new

    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')

    auction.add_item(item1)
    auction.add_item(item2)

    assert_equal [item1, item2], auction.items
  end

  def test_item_names
    auction = Auction.new

    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')

    auction.add_item(item1)
    auction.add_item(item2)

    assert_equal ['Chalkware Piggy Bank', 'Bamboo Picture Frame'], auction.item_names
  end

  def test_unpopular_items
    auction = Auction.new

    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)

    assert_equal [item2, item3, item5], auction.unpopular_items

    item3.add_bid(attendee2, 15)

    assert_equal [item2, item5], auction.unpopular_items
  end

  def test_potential_revenue
    auction = Auction.new

    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    assert_equal 87, auction.potential_revenue
  end

  def test_bidders
    auction = Auction.new

    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    assert_equal ["Megan", "Bob", "Mike"], auction.bidders
  end

  def test_bidder_info
    auction = Auction.new

    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expected = {
      attendee1 =>
      {
        budget: 50,
        items: [item1]
      },
      attendee2 =>
      {
        budget: 75,
        items: [item1, item3]
      },
      attendee3 =>
      {
        budget: 100,
        items: [item4]
      }
    }

    assert_equal expected, auction.bidder_info
  end
end
