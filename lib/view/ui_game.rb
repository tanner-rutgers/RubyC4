require 'test/unit'

require_relative 'ui_observer.rb'
require_relative 'ui_board.rb'
require_relative 'ui_status_info.rb'

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
        
	    @builder.get_object("gameWindow").signal_connect("delete-event") {@builder.get_object("gameWindow").hide}

        @views = Array.new
        @views.push(View::UiBoard.new(@builder, @model))
        @views.push(View::UiStatusInfo.new(@builder, @model))
      
        # Post-conditions / Class-invariants #
        assert_equal(@builder, builder, "GTK builder was not initialized")
        assert_equal(@model, model, "Model was not initialized")
        assert(!@views.nil?)
      end

      def update
        # Pre-conditions #
        #NA
        @views.each { |view| view.update }

        # Post-conditions #
        #NA
      end
      
      def get_view(clazz)
        @views.each {|view| return view if view.class == clazz}
        return nil
      end

    def show
        puts @model.gameType
        @builder.get_object("gameWindow").set_title(@model.gameType==:connect4 ? "Connect 4": "Otto&Toot")
        @builder.get_object("gameWindow").show()
        Gtk.main()
    end

    end
end
