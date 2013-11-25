require 'test/unit'

require_relative 'ui_observer.rb'
require_relative 'ui_board.rb'


module View
    class UiGame

      include UiObserver
      include Test::Unit::Assertions

      def initialize(builder, model)
        # Pre-conditions #
        assert(builder.is_a?(Gtk::Builder), "builder is not a Gtk::Builder")
        assert(model.is_a?(Model::Game))

        @builder = builder
        @model = model

        @views = Array.new

        @views.push(View::UiBoard.new(@builder, @model.board))
        #@views.push(View::UiPlayer.new(@builder, @model.players[0]))
        #@views.push(View::UiOpponent.new(@builder, @model.players[1]))

        @builder.get_object("mainWindow").show()
        Gtk.main()

        # Post-conditions / Class-invariants #
        assert_equal(@builder, builder, "GTK builder was not initialized")
        assert_equal(@model, model, "Model was not initialized")
        assert(!views.nil?)
      end

      def update
        # Pre-conditions #
        #NA
        @views.each { |view| view.update }
        setCurrentTurn
        # Post-conditions #
        #NA
      end

      # Display current turn information (label, indicator)
      def setCurrentTurn    
        player = @model.currentPlayersTurn
        colour = player.colour
        if player==@model.players[0]
          @builder.get_object('playerTurnImage').set_from_file('./resources/leftArrow_#{colour}.png')
          @builder.get_object('opponentTurnImage').hide
          turnLabel = "Your turn!"
        else
          @builder.get_object('playerTurnImage').hide
          @builder.get_object('opponentTurnImage').set_from_file('./resources/rightArrow_#{colour}.png')
          turnLabel = "Waiting for opponent!"
        end

        @builder.get_object('currentPlayerLabel').set_text(turnLabel)
      end

    end
end
