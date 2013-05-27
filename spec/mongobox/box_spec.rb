# spec/mongobox/box.spec.rb

require 'spec_helper'

describe Mongobox::Box do

  before :each do
    # prepare
  end

  after :each do
    # clean
  end

  it 'connect the localhost instance of Mongodb' do
    box = Mongobox::Box.new({database_name: 'test'})
    expect(box).to be_true
    expect(box.database).to be_a_kind_of(Mongo::DB)
  end

end
