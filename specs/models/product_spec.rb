require_relative '../spec_helper'

require_relative '../../models/product'

describe 'Product' do
  describe 'creates product object' do
    it "fails creating a product object without price" do
      assert_raises ArgumentError do
        Product.new(001, 'Lavender heart')
      end
    end

    it "create a product" do
      product = Product.new(001, 'Lavender heart', 925)

      assert product
    end
  end
end