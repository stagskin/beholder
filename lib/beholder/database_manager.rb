require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-aggregates'
require 'dm-validations'
require 'dm-core'
require 'dm-migrations'
require 'rubygems'
require 'dm-adjust'
require 'dm-types'

module Beholder
  module DatabaseManager

    DataMapper.setup(:default, 'sqlite:///home/stag/Projects/Beholder/beholder/lib/data/users.db')


    class Properties
      include DataMapper::Resource

      property :id, Integer, key: true
      property :'level.rb', Integer
      property :experience, Integer
      property :reputation, Integer
      property :join_date, Time
      property :active, Boolean

      DataMapper.finalize

    end
    class Properties
      def select_col(attr)
        return adapter.select("SELECT #{attr}")
      end

      def select_attr(table, col, value)
        return adapter.select("SELECT #{col} FROM #{table} WHERE #{col} = #{value}")
      end
    end
  end
end