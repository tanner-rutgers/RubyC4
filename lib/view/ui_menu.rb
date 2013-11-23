require 'test/unit'

class Menu
  include Observer
  include Test::Unit::Assertions

  def initialize
    # Pre-conditions #
    #NA

    # Post-conditions / Class-invariants #
    assert(!@models.nil?, "Models array not initialized")
    #NA
  end

  def update
    # Pre-conditions #
    #NA

    # Post-conditions #
    #NA
  end


end