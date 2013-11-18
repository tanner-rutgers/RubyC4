class Player

  include Test::Unit::Assertions

  def initialize(player, tokenColor)
    #Preconditions
    assert(player.is_a?Player)
    assert(tokenColor.is_a?Color)

    #Postconditions
    assert_equal(@player, player)
    assert_equal(@tokenColor, tokenColor)
  end

  def update()

  end
end