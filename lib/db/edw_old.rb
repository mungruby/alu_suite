 
 
# require_relative "sql_server'
 
 
module Alcatel
  #
  # Engineering Data Warehouse Playground
  #
  module EDW

    SOURCE = 'DWDSQL01\\SQL01'
    DATABASE = 'DM_Alcatel'

    # Tables
    CAMEL_CRITERIA_DATA       = 'dbo.callprocessing_CAMEL_N_CSI_DP_CRITERIA_DATA'
    CPCALLMCOUNTRYCODE        = 'dbo.callprocessing_CPCALLMCOUNTRYCODE'
    CPCALLMDIGITFENCE         = 'dbo.callprocessing_CPCALLMDIGITFENCE'
    CPCALLMDIGITTRANSLATOR    = 'dbo.callprocessing_CPCALLMDIGITTRANSLATOR'
    CPCALLMLATANXX            = 'dbo.callprocessing_CPCALLMLATANXX'
    CPCALLMLNPORDER           = 'dbo.callprocessing_CPCALLMLNPORDER'
    CPCALLMLRNLIST            = 'dbo.callprocessing_CPCALLMLRNLIST'
    CPCALLMORIGROUTING        = 'dbo.callprocessing_CPCALLMORIGROUTING'
    CPCALLMPREFIXTRANSLATOR   = 'dbo.callprocessing_CPCALLMPREFIXTRANSLATOR'
    HPLMN_ODB_MAPPING         = 'dbo.callprocessing_HPLMN_ODB_MAPPING'
    EMERGENCY_ZONE            = 'dbo.callprocessing_EMERGENCY_ZONE'
    MSCROUTELIST              = 'dbo.callprocessing_MSCROUTELIST'
    MSCTRUNKGROUPBUNDLE       = 'dbo.callprocessing_MSCTRUNKGROUPBUNDLE'
    SERVICE_CRITERIA          = 'dbo.callprocessing_SERVICE_CRITERIA'
    SERVICE_CRITERIA_LIST     = 'dbo.callprocessing_SERVICE_CRITERIA_LIST'
    TRANSLATIONTREEBOOKKEEPER = 'dbo.callprocessing_TRANSLATIONTREEBOOKKEEPER'

    EMSDIGITDESCRIPTOR        = 'dbo.emsdata_EMSDIGITDESCRIPTOR'
    EMSNATIONALTREESELECTOR   = 'dbo.emsdata_EMSNATIONALTREESELECTOR'
    EMSORIGROUTEPROFILELIST   = 'dbo.emsdata_EMSORIGROUTEPROFILELIST'
    EMSPREFIXFENCE            = 'dbo.emsdata_EMSPREFIXFENCE'

    COUNTRY_DIGIT_PREFIXES    = 'dbo.mmappconfigdata_MSC_CFG_COUNTRY_DIGIT_PREFIXES'
    COUNTRY_INFO              = 'dbo.mmappconfigdata_MSC_CFG_COUNTRY_INFO'
    IMSI_GLOBALTITLE          = 'dbo.mmappconfigdata_MSC_CFG_IMSI_GLOBALTITLE'
    MCC_MNC                   = 'dbo.mmappconfigdata_MSC_CFG_MCC_MNC'
    RESTRICTED_LAC_CELL       = 'dbo.mmappconfigdata_MSC_CFG_RESTRICTED_LAC_CELL'
    RESTRICTED_PLMN           = 'dbo.mmappconfigdata_MSC_CFG_RESTRICTED_PLMN'

    MSISDN_HLR                = 'dbo.subscriberdata_SPM_MSISDN_HLR'
    SPM_PCARD_CALLTYPE        = 'dbo.subscriberdata_SPM_PCARD_CALLTYPE'

    SYSGRPCONFIG              = 'dbo.systemconfiguration_SYSGRPCONFIG'




    # def self.query sql
    #   Database::SQLServer.query SOURCE, DATABASE, sql
    # end


    #
    #  Returns a list of the MSS Names that appear in the given table
    #
    # def self.mss_list db, table
    #   # default table to query for list of MSS Names
    #   # table ||= small_table
    #   db.query "SELECT MSSName FROM #{table};"
    #   db.data.uniq.flatten.compact.sort
    # end

    # def self.last_updated db, table, mss_name
    #   db.query <<-SQL
    #     SELECT top (1) LastUpdated
    #     FROM #{table}
    #     WHERE MSSName = '#{mss_name}'
    #   SQL
    #   db.data.flatten.first
    # end

  end
end
 
 
