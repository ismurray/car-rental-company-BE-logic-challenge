require 'json'
require './backend/classes/level_two/rental_processor'

describe LevelTwo::RentalProcessor do
  describe '.process' do
    let!(:input_hash) { JSON.parse(File.read('backend/level2/data/input.json')) }
    let(:expected_output) { JSON.parse(File.read('backend/level2/data/expected_output.json')) }

    it 'properly calculates and serializes the expected rental output' do
      expect(described_class.process(input_hash['cars'], input_hash['rentals'])).to eq(expected_output)
    end

    it 'ignores rentals that have an invalid car_id' do
      invalid_rental = { "id" => 1, "car_id" => 99, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 100 }

      expect(described_class.process(input_hash['cars'], input_hash['rentals'].push(invalid_rental))).to eq(expected_output)
    end

    it 'duplicate rental and car ids' do
      duplicate_rental = { "id" => 1, "car_id" => 1, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 999 }
      duplicate_car = { "id" => 1, "price_per_day" => 5000, "price_per_km" => 10 }

      expect(described_class.process(input_hash['cars'].push(duplicate_car), input_hash['rentals'].push(duplicate_rental))).to eq(expected_output)
    end
  end
end
