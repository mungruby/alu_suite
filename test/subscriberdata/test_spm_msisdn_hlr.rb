
require "minitest/autorun"
require_relative '../../lib/subscriberdata/spm_msisdn_hlr'

module Alcatel  

  module SubscriberData

    class SPM_MSISDN_HLR_Test < MiniTest::Unit::TestCase

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
        assert_equal "VGMSS861", SPM_MSISDN_HLR.find_by_mss("VGMSS861").data.first[1]
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
   
