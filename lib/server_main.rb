require "xmlrpc/server"
require_relative "Model/server/server.rb"

server = XMLRPC::Server.new(50500, ENV['HOSTNAME'])


server.add_handler("server", Model::Server.new)
server.serve

