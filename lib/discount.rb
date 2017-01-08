require_relative 'discount_types/fixed_discount'
require_relative 'discount_types/percentage_discount'

# Discount iterated promotional_rules passed to checkout giving discount in total amount
class Discount

  def self.final_value(items, promotional_rules)
    total = items.map(&:price).reduce(:+)

    # Sort promotional rules to apply spent_value rules as last discount
    promotional_rules = promotional_rules.sort { |pr| pr.discount_condition == :spent_value ? 1 : 0 }

    promotional_rules.each do |promotional_rule|
      # Dynamicly get discount class
      klazz = Object.const_get("#{promotional_rule.discount_type.capitalize}Discount")

      # decrease from total the discount amount
      total -= klazz.new(total, items).send( promotional_rule.discount_condition, promotional_rule )
    end

    return total
  end
end