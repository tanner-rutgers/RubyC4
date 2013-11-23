require 'test/unit'

class Token

  include Test::Unit::Assertions

  attr_reader :player, :imageFile

  def initialize(player)
    #Preconditions
    assert(player.is_a?Player)

    @player = player
    @imageFile = "./resources/" + player.color.to_s + ".png"

    #Postconditions
    assert_equal(@player, player)
    assert_equal(@tokenColor, tokenColor)
    assert(!@models.nil?, "Models array not initialized")
  end

  def update
    # Pre-conditions #
    #NA

    @imageFile = "./resources/" + player.color.to_s + ".png"

    # Post-conditions #
    #NA
  end
end