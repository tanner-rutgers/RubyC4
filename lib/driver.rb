require_relative 'Controller/game_controller.rb'
require_relative 'view/ui_game.rb'
require_relative 'Controller/board.rb'
require_relative 'Controller/colour.rb'
require_relative 'Controller/ai.rb'
require_relative 'Controller/file_menu.rb'
require_relative 'Model/colour.rb'


Gtk.init
@builder = Gtk::Builder::new
@builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))

players = [Model::Player.new("Player1", Model::Colour::RED), Model::Player.new("AI-Bob", Model::Colour::BLUE)]
gameModel = Model::Game.new(players)

game = View::UiGame.new(@builder, gameModel)

boardController = Controller::Board.new(@builder, gameModel, players[0])
boardController.addObserver(game.get_view(View::UiBoard)) 
boardController.addObserver(game.get_view(View::UiStatusInfo))

aiController = Controller::AI.new(@builder, players[0], players[1], gameModel)
aiController.addObserver(game.get_view(View::UiBoard))
aiController.addObserver(game.get_view(View::UiStatusInfo))
 
#When someone makes a move it will notify the AI controller it needs to make the next move.
boardController.addObserver(aiController)

colourController = Controller::Colour.new(@builder, players[0], players[1])
colourController.addObserver(game.get_view(View::UiBoard))

fileMenuController = Controller::FileMenu.new(@builder, gameModel)
fileMenuController.addObserver(game.get_view(View::UiBoard))
fileMenuController.addObserver(game.get_view(View::UiStatusInfo))

game.show
