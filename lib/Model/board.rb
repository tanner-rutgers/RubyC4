require 'test/unit'
require_relative 'player.rb'

module Model
  class Board

    include Test::Unit::Assertions

    class ColumnFullException < StandardError; end

    attr_reader :boardArray

    def initialize(*args)
      # -- Pre Conditions -- #

      assert(args.size == 1 && args[0].is_a?(Array) ||
                 args.size == 2 && args[0].is_a?(Integer) && args[1].is_a?(Integer))

      if(args.size == 1)
        args[0].each {|x| assert(x.is_a?(Array))}
        assert(args[0].size>0)
        args[0].each {|x| assert_equal(args[0][0].size, x.size)}
        args[0].each {|column|
          column.each { |element|
            assert(element.nil? || element.is_a?(Model::Player))
          }
        }
      end


      # -- Code -- #
      if(args.size == 1)
        @boardArray = args[0]
      else
        @boardArray = Array.new(args[1]) {Array.new(args[0])}
      end


      # -- Post Conditions -- #
      if(args.size == 1)
        assert_equal(args[0].size, @boardArray.size)
        assert_equal(args[0][0].size, @boardArray[0].size)
      else
        assert_equal(args[0], @boardArray[0].size)
        assert_equal(args[1], @boardArray.size)
      end
    end

    def who(x, y)
      boardSize = self.size
      assert(x < boardSize[:columns] && y < boardSize[:rows])
      assert(x >= 0 && y >=0)

      rval = @boardArray[x][y]

      assert(rval.is_a?Player || rval.nil?)

      rval
    end

    def addPiece(columnNumber, player)
      # -- Pre Conditions -- #
      assert(columnNumber > 0 && columnNumber < @boardArray.size)
      assert(player.is_a?(String))
      num_tokens_before_insert = numTokens(columnNumber)
      assert(num_tokens_before_insert>=0)
      # -- Code -- #

      nextRow = numTokens(columnNumber)

      raise ColumnFullException if nextRow >= @boardArray[columnNumber].size

      @boardArray[columnNumber][nextRow] = player

      # -- Post Conditions -- #
      assert_equal(@boardArray[columnNumber][num_tokens_before_insert],player)
      assert_equal(num_tokens_before_insert+1, numTokens(columnNumber))
    end

    def size
      return { :rows => @boardArray[0].size, :columns => @boardArray.size }
    end

    def numTokens(columnNumber)
      # -- Pre Conditions -- #
      assert(columnNumber.is_a?Integer)
      assert(columnNumber >= 0 && columnNumber < @boardArray.size)
      # -- Code -- #

      rval = @boardArray[columnNumber].count{|x| !x.nil?}

      # -- Post Conditions -- #
      assert(rval.is_a?(Integer))
      assert(rval >= 0 && rval < @boardArray.size)

      rval
    end

    def getLine(x, y, x_dir, y_dir, size)
      tokens = []

      (size).times do
        return nil if x >= @boardArray.size || y >= @boardArray[0].size || x < 0 || y < 0
        tokens.push(@boardArray[x][y])

        x+=x_dir
        y+=y_dir
      end

      tokens
    end

    def getLines(x, y, size)
      lines = []
      [-1, 0, 1].repeated_permutation(2) do |p|
        if p[0] != 0 || p[1] != 0
          line = getLine(x, y, p[0], p[1], size)
          lines.push(line) if !line.nil?
        end

      end
      lines
    end

    # === Object Methods === #
    def to_s
      string = "Model::Board(#{size[:rows]}, #{size[:columns]})\n"

      to_row_array.each{ |row|
        row.each{ |element|
          string += element.to_s + "\t" if !element.nil?

          string += "[Empty]" + "\t" if element.nil?
        }
        string += "\n"
      }

      string
    end

    def eql? (other)
      other.is_a?(Model::Board) && self == other
    end

    def == (other)
      other.respond_to?(:boardArray) && other.boardArray == self.boardArray
    end

    def hash
      return "Model::Board" ^ @boardArray.hash
    end


    private
    def to_row_array
      rows = Array.new(@boardArray[0].size) {Array.new}
      @boardArray.each{|column|
        column.each_with_index { |element, rowNum|
          rows[rowNum].push(element)
        }
      }
      rows
    end
  end
end
