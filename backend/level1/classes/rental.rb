require 'date'

class Rental
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
    rental_days = (end_date - start_date).to_i + 1
    distance * car.price_per_km + rental_days * car.price_per_day
  end
end
