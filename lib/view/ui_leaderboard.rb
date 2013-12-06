require 'test/unit'
require_relative 'ui_observer.rb'
require_relative '../Model/server/client.rb'

module View
	class UiLeaderboard
		include UiObserver
		include Test::Unit::Assertions

		def initialize(builder, client)
			# Pre conditions #
			assert(builder.is_a?(Gtk::Builder), "builder is not a Gtk Builder")
			assert(client.is_a?(Model::Client), "client is not a Client object")

			@builder = builder
			@client = client

			update

			# Post conditions #
			assert_equal(@builder, builder, "builder was not initialized")
			assert_equal(@client, client, "client was not initialized")
		end
		
		def update
			leaderboard = @client.getLeaderboard
			0.upto(9) do |i|
				entry = leaderboard[i]
				name = entry.nil? ? "" : entry[:name]
				wins = entry.nil? ? "" : "(#{entry[:wins]})"
				@builder.get_object("leaderLabelRank#{(i+1)}").set_text("#{name} #{wins}");
			end
		end

	end
end