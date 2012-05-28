 
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

    def self.data_objects name, fields, data
      fields = map_field_names_to_symbols fields
      dto = create_data_transfer_object name, fields
      map_data dto, data
    end

    def self.map_field_names_to_symbols fields
      fields.drop(3).map { |field_name| field_name.downcase.to_sym }
    end

    def self.create_data_transfer_object name, fields
      if Struct.constants.include? name.to_sym
        Struct.const_get name
      else
        Struct.new(name, *fields) do
          attr_accessor :mss_name, :last_updated
        end
      end
    end

    def self.map_data data_transfer_object, data
      data.map do |row|
        dto = data_transfer_object.new *row.drop(3)
        dto.mss_name = row[1]
        dto.last_updated = row[2]
        dto
      end
    end
     
  end
end
 
