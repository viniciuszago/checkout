require_relative '../spec_helper'

require_relative '../../models/product'
require_relative '../../models/promotional_rule'

describe 'PromotionalRule' do
  describe 'creates promotional rule object' do
    it "fails creating a promotional rule for spent value with product" do
      assert_raises RuntimeError do
        item1 = Product.new(001, 'Lavender heart', 925)

        PromotionalRule.new(:percentage, :spent_value, 2, 100, item1)
      end
    end

    it "create a promotional rule to all products" do
      promotional_rule1 = PromotionalRule.new(:percentage, :spent_value, 6000, 10)

      assert promotional_rule1
    end

    it "create a promotional rule to specific product" do
      item1 = Product.new(001, 'Lavender heart', 925)

      promotional_rule1 = PromotionalRule.new(:percentage, :quantity, 2, 10, item1)

      assert promotional_rule1
    end
  end
end