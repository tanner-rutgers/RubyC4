require 'test/unit'
require_relative 'player.rb'

module Model

  class WinCondition
    include Test::Unit::Assertions


    def initialize(*pattern)

      pattern.each { |element|
        assert(element.is_a?PatternElement)
      }

      @pattern = pattern;

      assert_equal(@pattern, pattern)
    end

    def hasWon?(board)
      boardSize = board.size
      boardSize[:columns].times do |i|
        boardSize[:rows].times do |j|
          lines = board.getLines(i, j, @pattern.size)

          lines.each do |line|
            hasWon = true
            @pattern.each_with_index do |patternElement, index|
              hasWon &= patternElement.match?(line[index])
            end

            return hasWon if hasWon
          end


        end
      end

      return false

    end

    def to_s
      string = "Model::WinCondition\n"
      string += @pattern.join(", ")
      string + "\n"
    end

    class PatternElement

      def self.ANY
        PatternElement.new("ANY") {|object| object.is_a?(Model::Player)}
      end

      def self.OTHER(player)
        PatternElement.new("OTHER") {|object| object.is_a?(Model::Player) && !object.eql?(player) }
      end

      def self.PLAYER(player)
        PatternElement.new("PLAYER") {|object| object.eql?(player)}
      end

      def match?(object)
        return @matchBlock.call(object)
      end

      def to_s
        "Model::WinCondition:PatternElement.#{@type}"
      end

      private
      def initialize (type, &block)
        @type = type
        @matchBlock = block
      end


    end

  end


end