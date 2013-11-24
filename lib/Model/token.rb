require 'test/unit'

module Model
	class Token
		include Test::Unit::Assertions

		self.colourMap = Hash[Model::Colour.constants.collect{ |colour| [colour, './resources/#{colour}.png'] }]
		self.colourMap[:empty] = './resources/empty.png'

		attr_reader :imageFile

		def initialize(colour)
			# Preconditions
			assert(!colourMap[colour].nil? || colour.nil?)

			if colour.nil?
				colour = :empty

			@imageFile = colourMap[colour]

			# Postconditions
			assert(!@imageFile.nil?)
		end
	end
end