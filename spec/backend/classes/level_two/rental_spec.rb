require './backend/classes/level_two/rental'
require './backend/classes/level_two/car'

describe LevelTwo::Rental do
  let(:car) { LevelTwo::Car.new(1, 2000, 10) }

  describe '#price' do
    it 'properly calculates the price with single day-based discount' do
      rental = LevelTwo::Rental.new(1, car, "2017-12-8", "2017-12-10", 100)
      expected_output = 100 * 10 + 1 * 2000 + 2 * 2000 * 0.9
      expect(rental.price).to eq(expected_output)
    end

    it 'properly calculates the price with multiple day-based discounts' do
      rental = LevelTwo::Rental.new(1, car, "2017-12-8", "2017-12-19", 100)
      expected_output = 100 * 10 + 1 * 2000 + 3 * 2000 * 0.9 + 6 * 2000 * 0.7 + 2 * 2000 * 0.5
      expect(rental.price).to eq(expected_output)
    end

    it 'properly calculates the price with no day-based discounts' do
      rental = LevelTwo::Rental.new(1, car, "2017-12-8", "2017-12-8", 100)
      expected_output = 100 * 10 + 1 * 2000
      expect(rental.price).to eq(expected_output)
    end
  end

  describe '#serialize' do
    it 'properly serializes the price and id' do
      rental = LevelTwo::Rental.new(1, car, "2017-12-8", "2017-12-10", 100)
      expect(rental.serialize).to eq({ 'id' => rental.id, 'price' => rental.price })
    end
  end
end
