# PromotionalRule object
# The only optional param here is `item`
# PromotionalRule has dynamic behavior, for example:
# `discount_type` and `discount_condition` fields set the classes and methods that we will use
# By now we have 2 `discount_type`:
# :percentage # which will calculate using a percentage value
# :fixed # which will calculate using a fixed amount
# And 2 `discount_conditions`:
# :spent_value # which will check if `total` of checkout is higher than `minimum_amount`
# :quantity # which will check if quantity of items in basket is higher than `minimum_amount`

class PromotionalRule
  attr_accessor :discount_type, :discount_condition, :minimun_amount, :discount_value, :item

  def initialize( discount_type, discount_condition, minimun_amount, discount_value, item=nil)
    @discount_type      = discount_type
    @discount_condition = discount_condition
    @minimun_amount     = minimun_amount
    @discount_value     = discount_value
    @item               = item

    # Check if condition is spent_value and an item is passed
    check_discount_condition
  end

  def apply_to_all
    item.nil? ? true : false
  end

  private

  # Spent Value discount condition must apply to checkout
  def check_discount_condition
    raise "Item must be nil on a `spent_value` discount" if discount_condition == :spent_value && !item.nil?
  end
end