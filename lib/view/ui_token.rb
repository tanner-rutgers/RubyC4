require 'test/unit'

class Token

  include Test::Unit::Assertions

  attr_reader :player, :imageFile

  def initialize(builder,boardModel,i,j)
    #Preconditions
    assert(builder.is_a?Gtk::Builder)
    assert(boardModel.is_a?Model::Board)
    assert(i.is_a?Numeric)
    assert(j.is_a?Numeric)
    assert(i >= 0 && i < boardModel.size.rows)
    assert(j >= 0 && j < boardModel.size.columns)

    @builder = builder
    @boardModel = boardModel
    @i = i
    @j = j
    
    player = @boardModel.who(i,j)
    if player.nil? 
      @tokenModel = Model::Token.new(:EMPTY)
    else
      @tokenModel = player.token
    end
    @tokenImage = Gtk::Image.new(Gdk::PixBuf.new(@tokenModel.imageFile))

    update

    #Postconditions
    assert_equal(@builder, builder)
    assert_equal(@boardModel, boardModel)
    assert(!@tokenModel.nil?)
    assert(!@tokenImage.nil?)
    assert_equal(@i, i)
    assert_equal(@j, j)
  end

  def update
    # Pre-conditions #
    #NA
    
    # Only load image file if the token has changed
    newModel = @boardModel.who(@i, @j).token
    if newModel != @tokenModel
      @tokenModel = newModel
      @tokenImage = Gtk::Image.new(Gdk::PixBuf.new(newModel.imageFile))
    end

    # Draw token
    @builder.get_object("piece" + (@i*@boardModel.size.rows+@j).to_s).set_from_pixbuf(@tokenImage)

    # Post-conditions #
    #NA
  end
end