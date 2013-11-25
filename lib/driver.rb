require_relative 'Controller/game_controller.rb'
require_relative 'view/ui_game.rb'
require_relative 'Controller/board.rb'
require_relative 'Controller/ai.rb'
require_relative 'Model/colour.rb'

#puts Model::Colour.constants.class

puts Model::Colour::RED

Gtk.init
@builder = Gtk::Builder::new
@builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))

yourColourButton = @builder.get_object("yourColourButton")
yourColourButton.signal_connect( "activate" ) { @builder.get_object('tokenChooserDialog').show }

players = [Model::Player.new("Player1", Model::Colour::RED), Model::Player.new("AI-Bob", Model::Colour::BLUE)]
gameModel = Model::Game.new(players)

game = View::UiGame.new(@builder, gameModel)

boardController = Controller::Board.new(@builder, gameModel, players[0])
boardController.addObserver(game.get_view(View::UiBoard)) 
boardController.addObserver(game.get_view(View::UiStatusInfo))

aiController = Controller::AI.new(players[1], players[0], gameModel)
aiController.addObserver(game.get_view(View::UiBoard))
aiController.addObserver(game.get_view(View::UiStatusInfo))

boardController.addObserver(aiController)



game.show
