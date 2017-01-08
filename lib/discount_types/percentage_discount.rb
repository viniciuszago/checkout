# PercentageDiscount will calculate discount using a percentage amount
# It has 2 `discount_conditions`:
# :spent_value # which will check if `total` of checkout is higher than `minimum_amount`
# :quantity # which will check if quantity of items in basket is higher than `minimum_amount`
class PercentageDiscount

  def initialize(total, items)
    @total = total
    @items = items
  end

  def spent_value(promotional_rule)
    @total >= promotional_rule.minimun_amount ? (@total * promotional_rule.discount_value) / 100 : 0
  end

  def quantity(promotional_rule)
    if promotional_rule.apply_to_all
      @items = @items.select { |i| @items.count(i) >= promotional_rule.minimun_amount }
    else
      @items = @items.select { |i| i == promotional_rule.item && @items.count(i) >= promotional_rule.minimun_amount }
    end


    @items.any? ? ((@items.map(&:price).reduce(:+) * promotional_rule.discount_value) / 100) : 0
  end
end