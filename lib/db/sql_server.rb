
require 'win32ole'
 
module DatabaseServer
 
  #
  # This class manages the database connection and queries for an SQL Server database
  #
  class SqlServer

    def self.create source, database
      db = SqlServer.new source, database
      db.open
        yield db
      db.close
    end

    def self.query source, database, sql
      db = SqlServer.new source, database
      db.open
      db.query sql
      db.close
      db
    end

    attr_accessor :source, :database, :connection, :fields, :data

    def initialize source, database
      @source = source
      @database = database
      @connection = nil
      @fields = nil
      @data = nil
    end

    #
    # Opens an ADO connection to the SQL Server database
    #
    def open
      @connection = WIN32OLE.new 'ADODB.Connection'
      @connection.Open <<-CONNECTION_STRING
        Provider=SQLOLEDB.1;
        Persist Security Info=False;
        Data Source=#{@source};
        Initial Catalog=#{@database};
        Trusted_Connection=Yes;
      CONNECTION_STRING
    end

    #
    # Performs an SQL query and populates the fields and data instance variables
    #
    def query sql

      # Create an instance of an ADO Recordset
      recordset = WIN32OLE.new 'ADODB.Recordset'

      # Open the recordset, using an SQL statement and the
      # existing ADO connection
      recordset.Open sql, @connection

      # Create and populate an array of field names
      @fields = []
      recordset.Fields.each {|f| @fields << f.Name }

      begin
        # Move to the first record/row, if any exist
        recordset.MoveFirst
        # Grab all records
        @data = recordset.GetRows
      rescue
          @data = []
      end

      # Close the recordset
      recordset.Close

      # An ADO Recordset's GetRows method returns an array
      # of columns, so we'll use the transpose method to
      # convert it to an array of rows
      @data = @data.transpose
    end

    #
    # Closes the database connection
    #
    def close
      @connection.Close
    end

  end
end

