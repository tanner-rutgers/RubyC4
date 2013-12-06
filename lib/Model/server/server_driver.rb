require "xmlrpc/server"
require_relative "server.rb"

server = XMLRPC::Server.new(50500)


server.add_handler("server", Model::Server.new)
server.serve

