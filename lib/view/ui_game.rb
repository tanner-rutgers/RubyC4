require 'test/unit'

class Game

  include Observer
  include Test::Unit::Assertions

  def initialize(builder, model, player)
    # Pre-conditions #
    assert(builder.is_a?Gtk::Builder, "builder is not a Gtk::Builder")
    assert(model.is_a?Model::Game)
    assert(player.is_a?Model::Player)

    @builder = builder
    @model = model
    @player = player

    @menuView = View::UiMenu.new
    @settingsView = View::UiSettings.new(@model.players)
    @boardView = View::UiBoard.new(@model.board)

    @builder.get_object("window1").show()
    Gtk.main()

    # Post-conditions / Class-invariants #
    assert_equal(@builder, builder, "GTK builder was not initialized")
    assert_equal(@model, model, "Model was not initialized")
    assert_equal(@player, player, "Player was not initialized")
    assert(!@menuView.nil?)
    assert(!@settingsView.nil?)
    assert(!boardView.nil?)
  end

  def update
    # Pre-conditions #
    #NA

    # Post-conditions #
    #NA
  end

end