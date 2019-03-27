require './backend/level1/classes/rental'
require './backend/level1/classes/car'

describe Rental do
  let(:car) { Car.new(1, 2000, 10) }
  let(:rental) { Rental.new(1, car, "2017-12-8", "2017-12-10", 100) }

  describe '#price' do
    it 'properly calculates the price' do
      expected_output = 100 * 10 + 3 * 2000
      expect(rental.price).to eq(expected_output)
    end
  end

  describe '#serialize' do
    it 'properly serializes the price and id' do
      expect(rental.serialize).to eq({ 'id' => rental.id, 'price' => rental.price })
    end
  end
end
