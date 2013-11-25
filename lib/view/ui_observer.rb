require 'test/unit'

require_relative "../Model/observer.rb"

module UiObserver
  extend Model::Observer

	def update
    #raise "Not Implemented Error"
  end

  def notify
    update
  end

end
