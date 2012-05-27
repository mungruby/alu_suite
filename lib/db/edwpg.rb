 
require_relative 'sql_server'
 
module Alcatel
  #
  # Engineering Data Warehouse Playground
  #
  module EDW

    SOURCE = 'DWDSQL01\\SQL01'
    DATABASE = 'DM_Alcatel'

    def self.query sql
      ::DatabaseServer::SqlServer.query SOURCE, DATABASE, sql
    end

  end
end
 
 
