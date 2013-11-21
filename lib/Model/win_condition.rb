require 'test/unit'
require_relative 'player.rb'

include Model

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
      #In Progress
    end

    def to_s
      string = "Model::WinCondition\n"
      string += @pattern.join(", ")
      string + "\n"
    end
  end

  class PatternElement

    def self.ANY
      PatternElement.new("ANY") {|object| object.is_a?Player}
    end

    def self.OTHER(player)
      PatternElement.new("OTHER") {|object| object.is_a?Player && !object.eql?(player) }
    end

    def self.PLAYER(player)
      PatternElement.new("PLAYER") {|object| object.eql?(player)}
    end

    def matches(object)
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