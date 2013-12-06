require 'test/unit'

require_relative 'ui_observer.rb'
require_relative '../Model/server/client.rb'

module View
	class ui_login.rb
		include UiObserver
		include Test::Unit::Assertions

		def initialize(builder)
			# Pre-conditions #
        	assert(builder.is_a?(Gtk::Builder), "builder is not a Gtk::Builder")

			@builder = builder

			# Post-conditions #
			assert_equal(@builder,builder, "builder was not initialized")
		end

		def update
			@builder.getObject("loginFailure").show()
		end

		def show
			@builder.getObject("loginFailure").hide()
			@builder.getObject("loginWindow").show()
		end

	end
end