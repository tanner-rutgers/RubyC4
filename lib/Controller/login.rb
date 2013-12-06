require 'test/unit'

require_relative 'observable.rb'
require_relative '../Model/server/client.rb'
require_relative '../view/ui_login.rb'
require_relative '../view/ui_game_list.rb'
require_relative '../view/ui_leaderboard.rb'
require_relative '../Controller/new_game.rb'
require_relative '../Controller/games_list.rb'

module Controller
  class Login
    include Test::Unit::Assertions
    include Controller::Observable
    
    def initialize(builder)
      # Pre conditions #
	  assert(builder.is_a?(Gtk::Builder), "builder is not a GTK builder")  
      
      @builder = builder
      @view = View::UiLogin.new(builder)


      setupHandlers
 
      # Post conditions #
      assert_equal(@builder,builder, "builder was not initialized")
    end

    def setupHandlers
    	loginButton = @builder.get_object("loginButton")
    	cancelButton = @builder.get_object("cancelButton")
    	passwordField = @builder.get_object("loginPassword")

    	loginButton.set_flags( Gtk::Widget::CAN_DEFAULT )
    	loginButton.grab_default
    	loginButton.signal_connect("clicked") { attemptLogin }
    	cancelButton.signal_connect("clicked") { Gtk.main_quit }
    	passwordField.signal_connect("activate") { attemptLogin }
    end

    def attemptLogin
    	username = @builder.get_object("loginUsername").text
    	password = @builder.get_object("loginPassword").text

    	begin
    		client = Model::Client.new(username, password)
    		
		gamesList = View::UiGameList.new(@builder, client)
    leaderboard = View::UiLeaderboard.new(@builder, client)
		newGameController = Controller::NewGame.new(@builder, client)
		newGameController.addObserver(gamesList)
		Controller::GamesList.new(@builder, client, newGameController)
		
		@builder.get_object("launchWindow").show
		
    		@view.hide
            
    	rescue Model::Client::AccessDeniedException
    		@view.update
    	end
    end
    
  end

end
