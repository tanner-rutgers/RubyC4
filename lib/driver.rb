require_relative 'Controller/game_controller.rb'
require_relative 'view/ui_game.rb'
require_relative 'Controller/board.rb'
#require_relative 'Model/colour.rb'

#puts Model::Colour.constants.class

Gtk.init
@builder = Gtk::Builder::new
@builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))



yourColourButton = @builder.get_object("yourColourButton")
yourColourButton.signal_connect( "activate" ) { @builder.get_object('tokenChooserDialog').show }

game = Model::Game.new

gameui = View::UiGame.new(@builder, game)
Controller::Board.new(@builder, game, gameui.get_view(View::UiBoard), game.players[0])


gameui.show
