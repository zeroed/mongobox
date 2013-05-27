# spec_helper.rb

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'
require 'mongobox'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus => true
  config.filter_run_excluding :broken => true
  config.color_enabled = true
  config.formatter = 'documentation'

  # https://github.com/rspec/rspec-expectations
  config.expect_with :rspec do |c|
    c.syntax = :expect # disables `should`
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

def setup
  @box = Mongobox::Box.new({database_name: 'foobar', login: 'foo', password: 'bar'})
end
def teardown
  # ...
end

def clean_mongodb
  @box.collections.each do |collection|
    unless collection.name =~ /^system\./
      collection.remove
    end
  end
end
