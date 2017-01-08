Checkout
===================

This project is a sample of a checkout that receives promotions dynamically. 

We have a market place with a set of **products:**

product_code | name | price 
--- | --- | ---
001 | Lavender heart  | 925 
002 | Personalised cufflinks | 4500 
003 | Kids T-shirt | 1995 

 **Obs**: Price are in `cents` to avoid float pitfalls.

We need to offer dynamical promotions to our customers, by the beginning we will have 2 type of promotions predefined, which are:

* If the checkout total cost is higher than £60, then the costumer gets 10% of discount
* If you buy 2 or more `Lavender heart` then the price drops to £8.50

The checkout can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules. 
Our  promotional rule object fits to dynamic promotions. As I said before,  by now we have these 2 **promotional rules** defined:

discount_type | discount_condition | minimun_amount | discount_value | item 
--- | --- | --- | --- | ---
:percentage | :spent_value | 6000 | 10 | 
:fixed | :quantity | 2 | 75 | product_code 001

With the fields `discount_type` and `discount_condition` we can extend our checkout just creating new handles for new promotion rules, as [here](https://github.com/viniciuszago/checkout/blob/master/lib/discount.rb)

##**Technical Specifications**
-------------

###**Dependencies:**

 * `ruby version 2.3.1`
 * `bundle`

### **To install gem dependencies:**
`bundle install`

### **To run test stack:**
`bundle exec rake test`

It will run everything inside `spec` folder, as described in `Rakefile`.
