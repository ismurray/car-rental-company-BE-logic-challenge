require 'json'
require './backend/level1/classes/rental_processor'

input_hash = JSON.parse(File.read('backend/level1/data/input.json'))

serialized_rentals = RentalProcessor.process(input_hash['cars'], input_hash['rentals'])

File.open("backend/level1/data/output.json","w") do |f|
  f.write(JSON.pretty_generate(serialized_rentals))
end
