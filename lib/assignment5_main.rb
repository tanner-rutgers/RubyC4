require 'rubygems'
require 'gtk2'
require_relative 'Controller/login.rb'
require_relative 'Controller/game_launcher.rb'


Gtk.init
builder = Gtk::Builder::new
builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))

Controller::Login.new(builder)

Gtk.main()
