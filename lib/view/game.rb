class Game

  include Observer
  include Test::Unit::Assertions

  def initialize
    # Pre-conditions #

    # Post-conditions / Class-invariants #
    assert(!@builder.nil?, "GTK builder was not initialized")
  end

  def update
    # Pre-conditions #
    #NA

    # Post-conditions #
    #NA
  end

end