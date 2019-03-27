require './backend/classes/level_one/rental'
require './backend/classes/level_one/car'

module LevelOne
  class RentalProcessor
    def self.process(cars_params, rentals_params)
      new(cars_params, rentals_params).process
    end

    def initialize(cars_params, rentals_params)
      @cars = generate_cars(cars_params)
      @rentals = generate_rentals(rentals_params)
    end

    def process
      { 'rentals' => rentals.values.map(&:serialize) }
    end

    private

    attr_reader :cars, :rentals

    def generate_cars(cars_params)
      cars_params.reduce({}) do |cars, car_params|
        cars[car_params['id']] = LevelOne::Car.new(car_params['id'], car_params['price_per_day'], car_params['price_per_km']) if cars[car_params['id']].nil?
        cars
      end
    end

    def generate_rentals(rentals_params)
      rentals_params.reduce({}) do |rentals, rental_params|
        car = cars[rental_params['car_id']]
        if !car.nil? && rentals[rental_params['id']].nil?
          rentals[rental_params['id']] = LevelOne::Rental.new(rental_params['id'], car, rental_params['start_date'], rental_params['end_date'], rental_params['distance'])
        end
        rentals
      end
    end
  end
end
