require 'test/unit'
require_relative '../lib/mongobox'

class TestMongobox < Test::Unit::Testcase
  def setup
    @box = Mongobox::Box.new({database_name: 'foobar', login: 'foo', password: 'bar'})
  end
  def teardown
    # ...
  end
  teardown :clean_mongodb
  def clean_mongodb
     @box.collections.each do |collection|
       unless collection.name =~ /^system\./
         collection.remove
       end
    end
  end
end
