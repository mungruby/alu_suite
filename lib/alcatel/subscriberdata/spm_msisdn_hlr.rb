 
require_relative '../../../lib/db/edwpg' 
 
module Alcatel 
 
  module SubscriberData
 
    class SPM_MSISDN_HLR

      # @dbbackup_file = 'SubscriberData/subscriberdata_spatial.SPM_MSISDN_HLR.bulk'
      # @columns = ["MSSID", "MSSName", "LastUpdated",
      #            "MSISDN_BEGIN", "MSISDN_END", "HLR_NUM", "PORTABLE", "HLR_TYPE", "ALT_HLR_NUM"]
      #

      @context = 'SPMMSISDNHLR'
      @edw_table = 'dbo.subscriberdata_SPM_MSISDN_HLR'

      def self.find_by_mss mss_name
        rs = EDW.query sql_find_by_mss(mss_name)
        convert_binary_fields rs.data
        map_to_objects rs.fields, rs.data
      end

      def self.sql_find_by_mss mss_name
        <<-SQL
          SELECT *
          FROM #{@edw_table}
          WHERE MSSName = '#{mss_name}'
          ORDER BY MSISDN_BEGIN
        SQL
      end

      def self.sql_find_by_digits msisdn_begin, msisdn_end
        <<-SQL
          SELECT *
          FROM #{@edw_table}
          WHERE MSISDN_BEGIN LIKE '{#{msisdn_begin}}%'
          AND MSISDN_END LIKE '{#{msisdn_end}}%'
          ORDER BY MSSName
        SQL
      end

      def self.convert_binary_fields data
        data.each do |row|
          row[3] = row[3].delete '{f}'
          row[4] = row[4].delete '{f}'
        end
      end

      def self.map_to_objects fields, data
        EDW.data_objects @context, fields, data
      end

    end
  end
end
 
 
if __FILE__ == $0 
  sql = 'SELECT top (1) * FROM dbo.subscriberdata_SPM_MSISDN_HLR'
  p Alcatel::EDW.query sql
end
 
 
