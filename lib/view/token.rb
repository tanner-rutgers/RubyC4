require 'test/unit'

class Token

  include Test::Unit::Assertions

  def initialize(player, tokenColor)
    #Preconditions
    assert(player.is_a?Player)
    assert(tokenColor.is_a?Color)

    #Postconditions
    assert_equal(@player, player)
    assert_equal(@tokenColor, tokenColor)
    assert(!@models.nil?, "Models array not initialized")
  end

  def update
    # Pre-conditions #
    #NA

    # Post-conditions #
    #NA
  end
end