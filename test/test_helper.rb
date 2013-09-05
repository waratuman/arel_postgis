require 'rubygems'
require 'bundler/setup'
require 'minitest/unit'
require 'turn/autorun'
require 'arel'
require 'arel/postgis'

require 'support/fake_record'
Arel::Table.engine = Arel::Sql::Engine.new(FakeRecord::Base.new)

class Module

  def test(name, &block)
    define_method("test_#{name.gsub(/[^a-z0-9']/i, "_")}".to_sym, &block)
  end

end