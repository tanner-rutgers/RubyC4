require 'test/unit'

class Game

  include Observer
  include Test::Unit::Assertions

  def initialize(gtkBuilder, model)
    # Pre-conditions #
    assert(gtkBuilder.is_a?Gtk::Builder, "gtkBuilder is not a Gtk::Builder")
    assert(model.is_a?Model::Game)

    @builder = gtkBuilder
    @model = model

    @menuView = View::UiMenu.new
    @settingsView = View::UiSettings.new(@model.players)
    @boardView = View::UiBoard.new(@model)

    @builder.get_object("window1").show()
    Gtk.main()

    # Post-conditions / Class-invariants #
    assert(!@builder.nil?, "GTK builder was not initialized")
    assert(!@models.nil?, "Models array not initialized")
    assert(!@board.nil?, "Board view not initialized")
    assert(!@menu.nil?, "Menu view not initialized")
  end

  def update
    # Pre-conditions #
    #NA

    # Post-conditions #
    #NA
  end

end