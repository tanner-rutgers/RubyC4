require 'test/unit'

module Model
	class Token
		include Test::Unit::Assertions

		FILEMAP = { 	:EMPTY => './resources/empty.png',
						:RED => './resources/red.png',
						:BLUE => './resources/blue.png',
						:BLACK => './resources/black.png',
						:WHITE => './resources/white.png',
						:GREEN => './resources/green.png',
						:PINK => './resources/pink.png' }

		attr_reader :imageFile

		def initialize(type)
			assert(FILEMAP.has_key?type)

			@imageFile = FILEMAP[type]

			assert_equal(@type, type)
		end

	end
end