
module Model
  class UserInformation

    include Test::Unit::Assertions

    def initialize(server)
      assert(server.is_a?Server)#Rename to actual server class.


      #post-conditions
      assert(!@server.nil?)
    end

    def login(username, password)
      #preconditions
      assert(username.is_a?String)
      assert(password.is_a?String)

    end

    def getGameList

      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(ClientGame))}
    end

    def getLeaderboard

      #post-conditions
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Array) && element.size == 2)}
    end

  end
end