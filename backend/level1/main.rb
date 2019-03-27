require 'json'
require './backend/classes/level_one/rental_processor'

input_hash = JSON.parse(File.read('backend/level1/data/input.json'))

serialized_rentals = LevelOne::RentalProcessor.process(input_hash['cars'], input_hash['rentals'])

File.open("backend/level1/data/output.json","w") do |f|
  f.write(JSON.pretty_generate(serialized_rentals))
end
