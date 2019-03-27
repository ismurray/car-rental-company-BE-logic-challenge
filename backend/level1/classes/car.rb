class Car
  def initialize(id, price_per_day, price_per_km)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  attr_reader :id, :price_per_day, :price_per_km
end
