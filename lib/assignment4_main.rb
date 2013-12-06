require 'rubygems'
require 'gtk2'
require_relative 'Controller/login.rb'


Gtk.init
builder = Gtk::Builder::new
builder.add_from_file(File.expand_path("../C4Ruby.glade", File.dirname(__FILE__)))

#clientBob = Model::Client.new("Bob", "Smith")

#GameController.new(builder, clientBob, "Bob", 125)

Controller::Login.new(builder)
Gtk.main()
