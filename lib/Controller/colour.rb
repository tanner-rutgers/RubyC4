require_relative '../Model/player.rb'
require_relative '../Model/colour.rb'
require_relative '../Controller/observable.rb'

module Controller
  class Colour
    include Observable

    @@RESPONSE_ACCEPT = 0
    @@RESPONSE_CANCEL = 3
    
    @@ColourMapping = {
        "blackRadio"  => Model::Colour::BLACK, 
        "blueRadio"   => Model::Colour::BLUE,
        "greenRadio"  => Model::Colour::GREEN,
        "redRadio"    => Model::Colour::RED,
        "pinkRadio"   => Model::Colour::PINK,
        "whiteRadio"  => Model::Colour::WHITE
    }

    def initialize(builder, player, opponent)
      @builder = builder
      @player = player
      @opponent = opponent

      setupHandlers
    end

    def setupHandlers
      
      yourColourButton = @builder.get_object("yourColourButton")
      opponentColourButton = @builder.get_object("opponentColourButton")
      
      opponentColourButton.signal_connect("activate") { openChooserDialog(@opponent) }
      yourColourButton.signal_connect( "activate" )   { openChooserDialog(@player) }    
    end

    def openChooserDialog(player)
      dialog = @builder.get_object('tokenChooserDialog')
      dialog.run { |response|
        case response
          when @@RESPONSE_ACCEPT
            player.colour = getColour
            notifyAll   
        end
        dialog.hide      
      }

    end

    def getColour
      @builder.get_object("blackRadio").group.each {|radio|
        return @@ColourMapping[radio.name] if radio.active?               
      }      
      #Code should never reach here.
      return nil?
    end

    
    
  end
end
