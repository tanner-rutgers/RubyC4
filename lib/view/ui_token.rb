require 'test/unit'
require 'rubygems'
require 'gtk2'

require_relative 'ui_observer.rb'
require_relative '../Model/token.rb'

module View
  class UiToken
    include Test::Unit::Assertions
    include UiObserver

    attr_reader :player, :imageFile

    def initialize(builder,gameModel,i,j)
      #Preconditions
      assert(builder.is_a?Gtk::Builder)
      assert(gameModel.is_a?Model::Game)
      assert(i.is_a?Numeric)
      assert(j.is_a?Numeric)
      assert(i >= 0 && i < gameModel.board.size[:columns])
      assert(j >= 0 && j < gameModel.board.size[:rows])

      @builder = builder
      @gameModel = gameModel
      @i = i
      @j = j
      
      @colour = @gameModel.board.who(i,j).nil? ? :empty : @gameModel.board.who(i,j).colour
      @tokenModel = Model::Token.new(@colour)

      update

      #Postconditions
      assert_equal(@builder, builder)
      assert_equal(@gameModel, gameModel)
      assert(!@colour.nil?)
      assert(!@tokenModel.nil?)
      assert_equal(@i, i)
      assert_equal(@j, j)
    end

    def update
      # Pre-conditions #
      #NA
      
      # Only load image file if the color has changed
      newColour = @gameModel.board.who(@i, @j).nil? ? :empty : @gameModel.board.who(@i, @j).colour
      
      @colour = newColour
      @tokenModel = Model::Token.new(@colour)
      @builder.get_object("piece#{@i}#{@j}" ).set_file(@tokenModel.imageFile)  


      # Draw token

      # Post-conditions #
      #NA
    end
  end
end
