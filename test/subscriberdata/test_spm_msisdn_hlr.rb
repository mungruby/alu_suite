
require "minitest/autorun"
require_relative '../../lib/alcatel/subscriberdata/spm_msisdn_hlr'

module Alcatel  

  module SubscriberData

    class Test_SPM_MSISDN_HLR < MiniTest::Unit::TestCase

      def test_sql_find_by_mss
        expected = "          SELECT *\n" +
                   "          FROM dbo.subscriberdata_SPM_MSISDN_HLR\n" +
                   "          WHERE MSSName = 'VGMSS861'\n" +
                   "          ORDER BY MSISDN_BEGIN\n"

        assert_equal expected, SPM_MSISDN_HLR.sql_find_by_mss("VGMSS861")
      end

      def test_sql_find_by_digits
        expected = "          SELECT *\n" +
                   "          FROM dbo.subscriberdata_SPM_MSISDN_HLR\n" +
                   "          WHERE MSISDN_BEGIN LIKE '{12012040000}%'\n" +
                   "          AND MSISDN_END LIKE '{12012040999}%'\n" +
                   "          ORDER BY MSSName\n"

        assert_equal expected, SPM_MSISDN_HLR.sql_find_by_digits("12012040000", "12012040999")
      end

      def test_find_all_by_mss
        assert_equal 'VGMSS861', SPM_MSISDN_HLR.find_by_mss('VGMSS861').first.mss_name
      end

      # #<DatabaseServer::SqlServer:0xfc6f30 @source="DWDSQL01\\SQL01", @database="DM_Alcatel", @connection=#<WIN32OLE:0xfc6f00>,
      # @fields=["MSSID", "MSSName", "LastUpdated", "MSISDN_BEGIN", "MSISDN_END", "HLR_NUM", "PORTABLE", "HLR_TYPE", "ALT_HLR_NUM"],
      # @data=[["{760B943A-C6F4-4755-B7FA-1F85D96B70FE}", "NVMSS969", 2012-05-26 03:46:31 -0700, "{13368587000fffff}", "{13368587999fffff}", 0, 0, 1, 0]]>

      def test_from_binary
        data=[["{760B943A-C6F4-4755-B7FA-1F85D96B70FE}", "NVMSS969", "2012-05-26 03:46:31 -0700",
               "{13368587000fffff}", "{13368587999fffff}", 0, 0, 1, 0]]

        actual = SPM_MSISDN_HLR.convert_binary_fields data
        assert_equal '13368587000', actual.first[3]
        assert_equal '13368587999', actual.first[4]
      end

      def test_map_to_objects
        fields=["MSSID", "MSSName", "LastUpdated",
                "MSISDN_BEGIN", "MSISDN_END", "HLR_NUM", "PORTABLE", "HLR_TYPE", "ALT_HLR_NUM"]
        data=[["{760B943A-C6F4-4755-B7FA-1F85D96B70FE}", "NVMSS969", "2012-05-26 03:46:31 -0700",
               "13368587000", "13368587999", 0, 0, 1, 0]]
        dto = SPM_MSISDN_HLR.map_to_objects(fields, data).first

        assert_equal 'NVMSS969', dto.mss_name
        assert_equal '2012-05-26 03:46:31 -0700', dto.last_updated
        assert_equal '13368587000', dto.msisdn_begin
        assert_equal '13368587999', dto.msisdn_end
      end

      #def test_msisdn_begin
      #  assert_equal 12012048000, @os.msisdn_begin
      #end

      #def test_msisdn_end
      #  assert_equal 12012048999, @os.msisdn_end
      #end

      #def test_to_csv
      #   _csv = "12012048000,12012048999,0,0,1,0"
      #   assert_equal _csv, @os.to_csv
      #end

      #def test_methods
      #  _methods = [:<=>, :cd, :query, :add, :mod, :del, :to_csv, :to_s]
      #  _methods.concat [:msisdn_begin, :msisdn_end, :hlr_num]
      #  _methods.concat [:portable, :hlr_type, :alt_hlr_num]
      #
      #  assert_equal _methods, @os.public_methods(false)
      #end

    end
  end
end
   
