class Auction
  attr_reader :items

  def initialize
    @items = []
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
      item.bids.empty?
    end
  end

  def potential_revenue
    @items.reduce(0) do |sum, item|
      item.bids.each do |attendee, price|
      current_high_bid = item.current_high_bid
      sum += current_high_bid
      end
    end
  end

  def bidders
    bidders_names = []
    @items.each do |item|
      item.bids.each_key do |key|
        bidders_names << key.name
      end
    end
    bidders_names.uniq
  end

  def bidder_info
    bidder_info_hash = {}
    @items.each do |item|
      item.bids.each do |key, value|
        bidder_info_hash[key] = {}
      end
    end

    @items.each do |item|
      item.bids.each do |key, value|
        bidder_info_hash[key] = {
          budget: key.budget,
          items: [item]
        }
      end
    end
    bidder_info_hash
  end
end
