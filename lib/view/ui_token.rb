require 'test/unit'
require 'rubygems'
require 'gtk2'

require_relative 'ui_observer.rb'

module View
  class UiToken
    include Test::Unit::Assertions
    include UiObserver

    attr_reader :player, :imageFile

    def initialize(builder,boardModel,i,j)
      #Preconditions
      assert(builder.is_a?Gtk::Builder)
      assert(boardModel.is_a?Model::Board)
      assert(i.is_a?Numeric)
      assert(j.is_a?Numeric)
      assert(i >= 0 && i < boardModel.size[:rows])
      assert(j >= 0 && j < boardModel.size[:columns])

      @builder = builder
      @boardModel = boardModel
      @i = i
      @j = j
      
      @colour = @boardModel.who(i,j).nil? ? :empty : @boardModel.who(i,j).colour
      @tokenModel = Model::Token.new(@colour)

      update

      #Postconditions
      assert_equal(@builder, builder)
      assert_equal(@boardModel, boardModel)
      assert(!@colour.nil?)
      assert(!@tokenModel.nil?)
      assert_equal(@i, i)
      assert_equal(@j, j)
    end

    def update
      # Pre-conditions #
      #NA
      
      # Only load image file if the color has changed
      newColour = @boardModel.who(@i, @j).nil? ? :empty : @boardModel.who(@i, @j).colour
      if newColour != @colour
        @colour = newColour
        @tokenModel = Model::Token.new(@colour)
        @builder.get_object("piece" + (@i*@boardModel.size[:rows]+@j).to_s).set_from_file(@tokenModel.imageFile)  
      end

      # Draw token

      # Post-conditions #
      #NA
    end
  end
end
