require 'test/unit'

require_relative 'colour.rb'

module Model
	class Token
		include Test::Unit::Assertions

    @@resources_path =  File.expand_path("../../resources", File.dirname(__FILE__))
		@@colourMap = Hash[Model::Colour.constants.collect{ |colour| [Model::Colour.const_get(colour), "#{@@resources_path}/#{Model::Colour.const_get(colour)}.png"] }]
		@@colourMap[:empty] = "#{@@resources_path}/empty.png"

		attr_reader :imageFile

		def initialize(colour)
			# Preconditions
			assert(!@@colourMap[colour].nil? || colour.nil?)

			if colour.nil?
				colour = :empty
      end

			@imageFile = @@colourMap[colour]

			# Postconditions
			assert(!@imageFile.nil?)

		end
	end
end
