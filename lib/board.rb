require 'test/unit'

class Board < Test::Unit::TestCase
	def initialize(arr)
		# -- Pre Conditions -- #
		assert(arr.kind_of?(Array))
		assert(arr.size>0)
		arr.each {|x| assert(x.kind_of?(Array))}
		size = arr[0].size
		assert(size>0)
		arr.each {|x| assert_equal(x.size,arr)
		
		# -- Code -- #
		@boardArray = arr

		# -- Post Conditions -- #
		assert_equal(@boardArray, arr)
	end
	def addPiece(columnNumber, player)
		# -- Pre Conditions -- #
		assert(columnNumber > 0 && columnNumber < @boardArray.size)
		assert(player.kind_of(String))		
		num_tokens_before_insert = @boardArray[columnNumber].count{|x| !x.nil?}
		assert(num_tokens_before_insert>=0)
		# -- Code -- #
		
		# -- Post Conditions -- #
		assert_equal(@boardArray[columnNumber][num_tokens_before_insert],player)
		num_tokens_after_insert = @boardArray[columnNumber].count{|x| !x.nil?}
		assert_equal(num_tokens_before_insert+1, num_tokens_after_insert)
	end
end
