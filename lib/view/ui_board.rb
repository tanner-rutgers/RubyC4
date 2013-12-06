require 'test/unit'
require_relative 'ui_observer.rb'
require_relative '../Model/colour.rb'
require_relative '../Model/game.rb'

module View
  class UiBoard
    include UiObserver
    include Test::Unit::Assertions

    @@resources_path =  File.expand_path("../../resources", File.dirname(__FILE__))
    @@colourMap = Hash[Model::Colour.constants.collect{ |colour| [Model::Colour.const_get(colour), "#{@@resources_path}/#{Model::Colour.const_get(colour)}.png"] }]
    @@colourMap[:empty] = "#{@@resources_path}/empty.png"
    
    def initialize(builder, gameModel)
      # Pre-conditions #
      assert(builder.is_a?Gtk::Builder)
      assert(gameModel.is_a?Model::Game)
      assert(gameModel.players.size <= Model::Colour.constants.size)
      
      @builder = builder
      @gameModel = gameModel
      
      @playerMap = Hash.new
            
      @gameModel.players.each_with_index do |player, i|
	@playerMap[player] = @@colourMap[Model::Colour.const_get(Model::Colour.constants[i])]
      end

      update

      # Post-conditions / Class-invariants #
      assert(!@builder.nil?, "Builder was not initialized")
      assert(!@gameModel.nil?, "Game model not initialized")
      assert(!@playerMap.nil?, "Player map not initialized")
    end

    # Update all spaces on board
    def update
      @gameModel.board.size[:columns].times do |i|
	@gameModel.board.size[:rows].times do |j|
	  
          player = @gameModel.board.who(i, j)
	  imageFile = @@colourMap[:empty]
	  imageFile = @playerMap[player] if !player.nil?
          @builder.get_object("piece#{i}#{j}" ).set_file(imageFile)  

	end
      end
    end
  end
end
