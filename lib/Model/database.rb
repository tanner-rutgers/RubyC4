require "mysql"
class Database
	def initialize()
		@db = Mysql.new("mysqlsrv.ece.ualberta.ca", "group2", "qypMR1DcpIzv", "group2",13010)
	end
	def query(s)
		@db.query(s)
	end
end
