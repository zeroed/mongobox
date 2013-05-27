# spec/mongobox/box.spec.rb

require 'spec_helper'

describe Mongobox::Box do

  before :all do
    @box = Mongobox::Box.new({database_name: 'test'})
  end

  before :each do
    # prepare
  end

  after :each do
    clean_mongodb
  end

  it 'connect the localhost instance of Mongodb' do
    expect(@box).to be_true
    expect(@box.database).to be_a_kind_of(Mongo::DB)
  end

  it 'get, creates and drop collections' do
    #FIXME!
    expect(@box.collections).to eq(['system.indexes'])
    @box.collection('test_collection')
    @box.store({foo: 'bar'})
    expect(@box.collection).to be_a_kind_of(Mongo::Collection)
    expect(@box.collections).to include('test_collection', 'system.indexes')
    expect(@box.collection.name).to eq('test_collection')
    @box.delete_collection
    expect(@box.collections).to eq(['system.indexes'])
    #expect{ @box.collection.name }.to raise_error
  end

end
