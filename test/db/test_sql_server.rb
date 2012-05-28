
require "minitest/autorun"
require_relative "../../lib/db/sql_server"

module DatabaseServer

  class TestSqlServer < MiniTest::Unit::TestCase

    SOURCE = 'DWDSQL01\\SQL01'
    DATABASE = 'DM_Alcatel'

    def setup
      @db = SqlServer.new SOURCE, DATABASE
    end

    def teardown
      @db = nil
    end

    def test_new
      assert_instance_of SqlServer, @db
    end

    def test_source_is_set
      assert_equal SOURCE, @db.source
    end

    def test_database_is_set
      assert_equal DATABASE, @db.database
    end

    def test_query_returns_SqlServer_object
      sql = 'SELECT top (1) LastUpdated FROM dbo.emsdata_EMSNATIONALTREESELECTOR'
      assert_equal SqlServer, SqlServer.query(SOURCE, DATABASE, sql).class
    end

    def test_query_sets_source
      sql = 'SELECT top (1) LastUpdated FROM dbo.emsdata_EMSNATIONALTREESELECTOR'
      assert_equal SOURCE, SqlServer.query(SOURCE, DATABASE, sql).source
    end

    def test_query_sets_database
      sql = 'SELECT top (1) LastUpdated FROM dbo.emsdata_EMSNATIONALTREESELECTOR'
      assert_equal DATABASE, SqlServer.query(SOURCE, DATABASE, sql).database
    end

    def test_query_sets_fields
      sql = 'SELECT top (1) LastUpdated FROM dbo.emsdata_EMSNATIONALTREESELECTOR'
      assert_equal ["LastUpdated"], SqlServer.query(SOURCE, DATABASE, sql).fields
    end

    def test_query_sets_data
      sql = 'SELECT top (1) LastUpdated FROM dbo.emsdata_EMSNATIONALTREESELECTOR'
      rs = SqlServer.query SOURCE, DATABASE, sql
      assert_instance_of Array, rs.data
      assert_instance_of Array, rs.data.first
      assert_instance_of Time, rs.data.first.first
    end

  end
end
 
