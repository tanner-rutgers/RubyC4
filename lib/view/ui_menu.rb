require 'test/unit'

require_relative 'ui_observer.rb'

module View
  class UiMenu
    include UiObserver
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
end
