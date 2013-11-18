require_relative 'observer.rb'

class Board
	include Observer
	include Test::Unit::Assertions

	def initialize()
		# Pre-conditions #

		# Post-conditions / Class-invariants #
		assert(!@builder.nil?, "GTK builder was not initialized")
		assert(!@models.nil?, "Models array not initialized")
		assert(!@tokens.nil?, "Tokens not initialized")
	end

	def update
		# Pre-conditions #
		
		# Post-conditions #	
	end

	def setUp
		# Pre-conditions #

		# Post-conditions #
	end
end