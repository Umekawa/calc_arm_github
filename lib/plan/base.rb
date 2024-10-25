# frozen_string_literal: true

module Plan
  class Base
    def price(storage_price, minutes_price, other_price)
      (fixed_storage_price(storage_price) + fixed_minutes_price(minutes_price) + other_price).round(2)
    end

    def fixed_storage_price(storage_price)
      [(storage_price - (0.25 * free_storage_megabytes / 1000)).round(2), 0].max
    end

    def fixed_minutes_price(minutes_price)
      [(minutes_price - (0.008 * free_action_minutes)).round(2), 0].max
    end

    def free_action_minutes
      raise
    end

    def free_storage_megabytes
      raise
    end
  end
end
