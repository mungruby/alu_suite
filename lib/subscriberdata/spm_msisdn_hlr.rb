 
 
require_relative '../../lib/db/edwpg' 
 
 
module Alcatel 
 
  module SubscriberData
 
    class SPM_MSISDN_HLR

      @table = 'dbo.subscriberdata_SPM_MSISDN_HLR'

      # @dbbackup_file = 'SubscriberData/subscriberdata_spatial.SPM_MSISDN_HLR.bulk'
      # @edw_table = 'dbo.subscriberdata_SPM_MSISDN_HLR'
      # @columns = ["MSSID", "MSSName", "LastUpdated",
      #            "MSISDN_BEGIN", "MSISDN_END", "HLR_NUM", "PORTABLE", "HLR_TYPE", "ALT_HLR_NUM"]
      #
      # def initialize source
      #   @source = source
      # end


      #
      # Class methods for database queries
      #

      def self.find_by_mss mss_name
        # [[nil,nil],[nil,nil]]
        EDW.query sql_find_by_mss(mss_name)
        # puts sql_find_by_mss(mss_name).class
        # p sql_find_by_mss(mss_name)
      end

      def self.sql_find_by_mss mss_name
        <<-SQL
          SELECT *
          FROM #{@table}
          WHERE MSSName = '#{mss_name}'
          ORDER BY MSISDN_BEGIN
        SQL
      end

      def self.sql_find_by_digits msisdn_begin, msisdn_end
        <<-SQL
          SELECT *
          FROM #{@table}
          WHERE MSISDN_BEGIN LIKE '{#{msisdn_begin}}%'
          AND MSISDN_END LIKE '{#{msisdn_end}}%'
          ORDER BY MSSName
        SQL
      end


      #
      # Instance methods for database queries
      #

      #def find_all_by_MSSName db, mss
      #  db.query <<-SQL
      #    SELECT MSISDN_BEGIN, MSISDN_END, HLR_NUM, LastUpdated
      #    FROM #{@table}
      #    WHERE MSSName = '#{mss}'
      #    ORDER BY MSISDN_BEGIN
      #  SQL
      #  db.data.each do |row|
      #    row[0] = row[0].delete('{f}')
      #    row[1] = row[1].delete('{f}')
      #  end
      #end

      #def find_all_by_digits db, digits
      #  arr = digits.split("-")
      #  db.query <<-SQL
      #    SELECT *
      #    FROM #{@table}
      #    WHERE MSISDN_BEGIN LIKE '{#{arr[0]}%'
      #    AND MSISDN_END LIKE '{#{arr[1]}%'
      #    ORDER BY MSSName
      #  SQL
      #  db.data.each do |row|
      #    row[3] = row[3].delete('{f}')
      #    row[4] = row[4].delete('{f}')
      #  end
      #end


      #
      # Class methods for BINARY conversions
      #

      def self.to_binary digits
        arr0 = Array.new(8, "f")
        arr1 = Array.new(8, "f")

        arr, idx = 0, 0
        hex_length = digits.length.to_s(16)

        digits.each_char do |ch|
          case arr
            when 0 then arr0[idx] = ch
            when 1 then arr1[idx] = ch; idx += 1
          end
          arr == 0 ? arr = 1 : arr = 0
        end

        digits = ""
        arr0.length.times {|i| digits << "#{arr1[i]}#{arr0[i]}"}
        "{0#{hex_length}#{digits}}"
      end


      def self.from_binary str
        arr0 = Array.new(8)
        arr1 = Array.new(8)

        arr, idx = 0, 0
        str = str.slice 3..18

        str.each_char do |ch|
          case arr
            when 0 then arr0[idx] = ch
            when 1 then arr1[idx] = ch; idx += 1
          end
          arr == 0 ? arr = 1 : arr = 0
        end

        digits = ""
        arr0.length.times {|i| digits << "#{arr1[i]}#{arr0[i]}"}
        "#{digits}".delete("f")
      end

    end
  end
end
 
 
