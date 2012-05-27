#!/usr/bin/env ruby -w


require_relative '../lib/alcatel_auditing_tool'
 
 
module Alcatel 
 
  #
  # SPATIAL.SPM_MSISDN_HLR, 6 columns, dumped Mon Mar 26 03:46:19 2012
  # columns:
  #      1. MSISDN_BEGIN BINARY(8)
  #      2. MSISDN_END   BINARY(8)
  #      3. HLR_NUM      INTEGER
  #      4. PORTABLE     TINYINT
  #      5. HLR_TYPE     TINYINT
  #      6. ALT_HLR_NUM  INTEGER
  # end
  #
  class MsisdnHlrAuditTool < AlcatelAuditingTool
 
    # @dbbackup_file = 'SubscriberData/subscriberdata_spatial.SPM_MSISDN_HLR.bulk'
    # @edw_table = 'dbo.subscriberdata_SPM_MSISDN_HLR'
    @columns = ["MSSID", "MSSName", "LastUpdated",
                "MSISDN_BEGIN", "MSISDN_END", "HLR_NUM", "PORTABLE", "HLR_TYPE", "ALT_HLR_NUM"]
 
    def initialize command, parms
      @table = EDW::DM_ALCATEL::MSISDN_HLR
      super
    end


    #
    # Instance methods for database queries
    #
     
    def find_all_by_MSSName db, mss
      db.query <<-SQL
        SELECT MSISDN_BEGIN, MSISDN_END, HLR_NUM, LastUpdated
        FROM #{@table}
        WHERE MSSName = '#{mss}'
        ORDER BY MSISDN_BEGIN
      SQL
      db.data.each do |row|
        row[0] = row[0].delete('{f}')
        row[1] = row[1].delete('{f}')
      end
    end

    def find_all_by_digits db, digits
      arr = digits.split("-")
      db.query <<-SQL
        SELECT *
        FROM #{@table}
        WHERE MSISDN_BEGIN LIKE '{#{arr[0]}%'
        AND MSISDN_END LIKE '{#{arr[1]}%'
        ORDER BY MSSName
      SQL
      db.data.each do |row|
        row[3] = row[3].delete('{f}')
        row[4] = row[4].delete('{f}')
      end
    end

     
    #
    # Instance methods for generating CLI commands
    #

    # cd; cd Office-Parameters/Routing-and-Translation/MSISDN-To-HLR;
    def cd
      puts "cd;"
      puts "cd Office-Parameters;"
      puts "cd Routing-and-Translation;"
      puts "cd MSISDN-To-HLR;"
      puts
    end
     
    def add_cli values
      arr = @digits.split("-")
      "add #{self.class.context} MSISDN_Begin=#{arr[0]}, MSISDN_End=#{arr[1]}, HLR_Number=0;"
    end
     
    def mod_cli arr
      "mod #{self.class.context} MSISDN_Begin=#{arr[3]}, MSISDN_End=#{arr[4]}, HLR_Number=#{arr[5]};"
    end
     
    def backout_cli arr
      "add #{self.class.context} MSISDN_Begin=#{arr[3]}, MSISDN_End=#{arr[4]}, HLR_Number=#{arr[5]};"
    end
     
     
    #
    # Class methods for generating CLI commands
    #

    def self.cli_query items
      items.map {|arr| "query #{arr[0]}-#{arr[1]}-#{context};"}
    end 

    def self.cli_add items
      items.map {|arr| "add #{context} MSISDN_Begin=#{arr[0]}, MSISDN_End=#{arr[1]}, HLR_Number=#{arr[2]};"}
    end 

    def self.cli_mod items
      items.map {|arr| "mod #{context} MSISDN_Begin=#{arr[0]}, MSISDN_End=#{arr[1]}, HLR_Number=#{arr[2]};"}
    end 

    def self.cli_del items
      items.map {|arr| "del #{arr[0]}-#{arr[1]}-#{context};"}
    end 


    #
    # Class methods for help menus and reuse
    #

    def self.context
      "SPMMSISDNHLR"
    end

    def self.parameter
      "MSISDN_BEGIN-MSISDN_END"
    end
     
    def self.value  
      "13102566000-13102566999"
    end

     
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
 
 
 
if __FILE__ == $0 
  Alcatel::MsisdnHlrAuditTool.new(ARGV.shift, ARGV).run
end
 
 
 
