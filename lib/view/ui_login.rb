require 'test/unit'

require_relative 'ui_observer.rb'

module View
	class UiLogin
		include UiObserver
		include Test::Unit::Assertions

		def initialize(builder)
			# Pre-conditions #
        	assert(builder.is_a?(Gtk::Builder), "builder is not a Gtk::Builder")

			@builder = builder
			show

			# Post-conditions #
			assert_equal(@builder,builder, "builder was not initialized")
		end

		def update
			@builder.get_object("loginFailure").show()
		end

		def show
			@builder.get_object("loginFailure").hide()
			@builder.get_object("loginWindow").show()
		end

		def hide
			@builder.get_object("loginWindow").hide()
		end

	end
end