require 'test/unit'

module Model
  class Server

    def login(username, password)
      #preconditions
      assert(username.is_a?String)
      assert(password.is_a?String)
    end

    def board(gameId)
      assert(gameId.is_a?Integer)

      assert(rval.is_a?(Game) || rval.nil?)
    end

    def makeMove(gameId, user, move)
      assert(gameId.is_a?Integer)
      assert(move.is_a?Integer)
      assert(user.is_a?User)


    end

    def whosTurn(gameId)
      assert(gameId.is_a?Integer)

      assert(rval.is_a?User)
    end

    def getGameList(user)
      assert(user.is_a?User)

      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Integer))}
    end

    def getLeaderboard

      #post-conditions
      assert(rval.is_a?Array)
      rval.each{|element| assert(element.is_a?(Array) && element.size == 2)}
    end

  end
end
