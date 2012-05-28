
require "minitest/autorun"
require_relative "../../lib/db/edwpg"

module Alcatel
  module EDW
    class TestEDW < MiniTest::Unit::TestCase

      SOURCE = 'DWDSQL01\\SQL01'
      DATABASE = 'DM_Alcatel'

      def test_source
        assert_equal SOURCE, EDW::SOURCE
      end

      def test_database
        assert_equal DATABASE, EDW::DATABASE
      end

      def test_query
        sql = 'SELECT top (1) LastUpdated FROM dbo.emsdata_EMSNATIONALTREESELECTOR'
        assert_equal DatabaseServer::SqlServer, EDW.query(sql).class
      end

    end
  end
end
 
