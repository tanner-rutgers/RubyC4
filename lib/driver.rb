require_relative 'Controller/game_controller.rb'
require_relative 'view/ui_game.rb'
require_relative 'Controller/board.rb'
require_relative 'Controller/ai.rb'
#require_relative 'Model/colour.rb'

#puts Model::Colour.constants.class

Gtk.init
@builder = Gtk::Builder::new
@builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))

yourColourButton = @builder.get_object("yourColourButton")
yourColourButton.signal_connect( "activate" ) { @builder.get_object('tokenChooserDialog').show }

gameModel = Model::Game.new

game = View::UiGame.new(@builder, gameModel)

boardController = Controller::Board.new(@builder, gameModel,gameModel.players[0])
boardController.addObserver(game.get_view(View::UiBoard)) 

aiController = Controller::AI.new(gameModel)
aiController.addObserver(game.get_view(View::UiBoard))

boardController.addObserver(aiController)



game.show
