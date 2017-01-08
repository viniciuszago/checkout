# Product object
# Every product has product_code, name and price
class Product
  attr_accessor :product_code, :name, :price

  def initialize(product_code, name, price)
    @product_code = product_code
    @name         = name
    @price        = price
  end
end