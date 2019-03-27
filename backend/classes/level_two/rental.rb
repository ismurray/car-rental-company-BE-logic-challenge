require 'date'

module LevelTwo
  class Rental
    INTERVALS_WITH_DISCOUNTS = [[1, 1.0], [3, 0.9], [6, 0.7], [nil, 0.5]]

    def initialize(id, car, start_date, end_date, distance)
      @id = id
      @car = car
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @distance = distance
      @price = calculate_price
    end

    def serialize
      { 'id' => id, 'price' => price }
    end

    attr_reader :id, :car, :start_date, :end_date, :distance, :price

    private

    def calculate_price
      distance * car.price_per_km + time_based_price
    end

    def time_based_price
      rental_days = (end_date - start_date).to_i + 1
      base_price_days = [car.price_per_day] * rental_days

      INTERVALS_WITH_DISCOUNTS.map do |interval_size, discount|
        base_price_days.shift(interval_size || base_price_days.length).reduce(0, :+) * discount
      end.reduce(0, :+).to_i
    end
  end
end
