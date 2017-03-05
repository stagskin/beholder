require 'table_print'
require 'data_mapper'
require_relative '../../../lib/beholder/database_manager'

module Beholder
  module StatBoard

    def self.post_user_stats
      @users = repository(:default).adapter.select("SELECT * FROM beholder_database_manager_properties").to_a
      @table = TablePrint::Printer.new(@users).table_print
      return @table
    end
    end
end