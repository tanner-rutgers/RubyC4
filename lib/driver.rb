require_relative 'Controller/game_controller.rb'
#require_relative 'Model/colour.rb'

#puts Model::Colour.constants.class

Gtk.init
@builder = Gtk::Builder::new
@builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))


window = @builder.get_object("mainWindow")
window.show

Gtk.main()
