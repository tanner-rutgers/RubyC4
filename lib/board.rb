require 'test/unit'

module Model
  class Board < Test::Unit::TestCase
    def initialize(arr)
      # -- Pre Conditions -- #
      assert(arr.kind_of?(Array))
      assert(arr.size>0)
      arr.each {|x| assert(x.is_a?(Array))}
      size = arr[0].size
      assert(size>0)
      arr.each {|x| assert_equal(x.size,arr)}

      # -- Code -- #
      @boardArray = arr

      # -- Post Conditions -- #
      assert_equal(@boardArray, arr)
    end

    def addPiece(columnNumber, player)
      # -- Pre Conditions -- #
      assert(columnNumber > 0 && columnNumber < @boardArray.size)
      assert(player.is_a?(String))
      num_tokens_before_insert = numTokens(columnNumber)
      assert(num_tokens_before_insert>=0)
      # -- Code -- #

      # -- Post Conditions -- #
      assert_equal(@boardArray[columnNumber][num_tokens_before_insert],player)
      num_tokens_after_insert = numTokens(columnNumber)
      assert_equal(num_tokens_before_insert+1, num_tokens_after_insert)
    end

    def size
      return @boardArray.size, @boardArray[0].size
    end

    def numTokens(column)
      # -- Pre Conditions -- #
      assert(column.is_a?Integer)
      assert(column >= 0 && column < @boardArray.size)
      # -- Code -- #

      # -- Post Conditions -- #
      assert(rval.is_a?(Integer))
      assert_equal(rval, @boardArray[columnNumber].count{|x| !x.nil?})
    end
  end
end
