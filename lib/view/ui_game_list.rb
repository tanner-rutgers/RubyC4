require 'test/unit'
require_relative 'ui_observer.rb'
require_relative '../Model/server/client.rb'

module View
	class UiGameList
		include UiObserver
		include Test::Unit::Assertions

		def initialize(builder, client)
			# Pre conditions #
			assert(builder.is_a?(Gtk::Builder), "builder is not a Gtk Builder")
			assert(client.is_a?(Model::Client), "client is not a Client object")

			@builder = builder
			@client = client

			# Post conditions #
			assert_equal(@builder, builder, "builder was not initialized")
			assert_equal(@client, client, "client was not initialized")
		end

		def update
			listStore = @builder.get_object("gamesListStore")
			listStore.clear

			@client.getGameList.each do |game|
				entry = listStore.append
				entry.set_value(0, game.get(:id))
				entry.set_value(1, game.get(:opponent).name)
				entry.set_value(2, game.get(:type))
				entry.set_value(3, game.get(:turn).name)
				entry.set_value(4, game.get(:timestamp))
			end
		end

	end
end