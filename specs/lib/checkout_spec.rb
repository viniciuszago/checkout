require_relative '../spec_helper'

require_relative '../../lib/checkout'
require_relative '../../models/product'
require_relative '../../models/promotional_rule'

describe 'Checkout' do
  before do
    # Create products
    # For more information about promotional rule access Product model
    # Create products that will be used in this tests
    @item1 = Product.new(001, 'Lavender heart', 925)
    @item2 = Product.new(002, 'Personalised cufflinks', 4500)
    @item3 = Product.new(003, 'Kids T-shirt', 1995)

    # Create promotional rules
    # For more information about promotional rule access PromotionalRule model
    # Discount rule by value spent
    @promotional_rule1 = PromotionalRule.new(:percentage, :spent_value, 6000, 10)

    # Discount rule for product amount
    @promotional_rule2 = PromotionalRule.new(:fixed, :quantity, 2, 75, @item1)

    # Discount rule for product amount
    @promotional_rule3 = PromotionalRule.new(:percentage, :quantity, 5, 100, @item3)

    # Discount rule for product amount (applying to all products)
    @promotional_rule4 = PromotionalRule.new(:percentage, :quantity, 2, 100)
  end

  describe 'Checkout product with promotional rules' do
    it 'gives a discount for total is higher than $60' do
      co = Checkout.new([@promotional_rule1, @promotional_rule2, @promotional_rule3, @promotional_rule4])

      co.scan(@item1)
      co.scan(@item2)
      co.scan(@item3)

      # As the sum of products is 7420 we apply discount by spent_value
      # We apply promotional_rule1 that has 10% of discount
      # so 7420 * 10 / 100 = 742
      # 7420 - 742 = 6678

      co.total.must_equal 6678
    end

    it 'gives a discount for multiple items' do
      co = Checkout.new([@promotional_rule1, @promotional_rule2])

      co.scan(@item1)
      co.scan(@item3)
      co.scan(@item1)

      # As we have 2 item1 and it applies to promotional_rule2
      # We give discount by fixed price of 75 cents
      # so (925 * 2) - (75 * 2) + 1995 = 3695

      co.total.must_equal 3695
    end

    it 'gives a discount for multiple items and total higher than $60' do
      co = Checkout.new([@promotional_rule1, @promotional_rule2])

      co.scan(@item1)
      co.scan(@item2)
      co.scan(@item1)
      co.scan(@item3)

      # As we have 2 item1 and it applies to promotional_rule2
      # We give discount by fixed price of 75 cents
      # so (925 * 2) - (75 * 2) + 4500 + 1995 = 8195
      # As the sum of products is 8345 we apply discount by spent_value
      # We apply promotional_rule1 that has 10% of discount
      # so 8195 * 10 / 100 = 819
      # 8195 - 819 = 7376

      co.total.must_equal 7376
    end

    it 'free checkout for five of item3' do
      co = Checkout.new([@promotional_rule3])

      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)

      # As we have 5 item3 and it applies to promotional_rule3
      # We give 100% of discount in total value

      co.total.must_equal 0
    end

    it 'pay only for item1 with discount' do
      co = Checkout.new([@promotional_rule1, @promotional_rule2, @promotional_rule3])

      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item1)
      co.scan(@item1)

      # As we have 5 item3 and it applies to promotional_rule3
      # We give 100% of discount in item3 value
      # As we have 2 item1 and it applies to promotional_rule2
      # We give discount by fixed price of 75 cents
      # so (925 * 2) - (75 * 2) = 17000

      co.total.must_equal 1700
    end

    it 'does not give any discount without promotional rules' do
      co = Checkout.new([])

      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)
      co.scan(@item3)

      # As we don't apply any promotional_rule to the checkout
      # the cost will be total without discount
      # (1995 * 5) = 9975

      co.total.must_equal 9975
    end

    it 'gives a discount for multiple items' do
      co = Checkout.new([@promotional_rule4])

      co.scan(@item1)
      co.scan(@item3)
      co.scan(@item1)
      co.scan(@item3)

      # As we have 2 item1 and 2 item3 it applies to promotional_rule4
      # that give 100% of discount

      co.total.must_equal 0
    end

  end
end