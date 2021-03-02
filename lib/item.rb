class Item
  attr_reader :name,
              :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, price)
    @bids[attendee] = price
  end

  def current_high_bid
    @bids.map do |attendee, price|
      price
    end.max
  end

  def close_bidding
    # @bids.delete
  end
end
