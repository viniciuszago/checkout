require_relative 'discount'

# This is responsible to scan items and return a total value for the checkout
class Checkout

  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @items             = []
  end

  def scan(item)
    @items << item
  end

  def total
    # If no promotional rule just return full value
    return @items.map(&:price).reduce(:+) if @promotional_rules.empty?

    # Call discount class to check discount
    Discount.final_value(@items, @promotional_rules)
  end
end