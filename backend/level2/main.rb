require 'json'
require './backend/classes/level_two/rental_processor'

input_hash = JSON.parse(File.read('backend/level2/data/input.json'))

serialized_rentals = LevelTwo::RentalProcessor.process(input_hash['cars'], input_hash['rentals'])

File.open("backend/level2/data/output.json","w") do |f|
  f.write(JSON.pretty_generate(serialized_rentals))
end
