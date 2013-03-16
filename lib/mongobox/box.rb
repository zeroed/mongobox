module Mongobox
  require 'mongo'
  
  module Constants
    
    UserKeyPath = "config/db-user"
    MongolabUrl = "mongodb://ds051077.mongolab.com:51077"
  
  end # Constants

  class Box
    
    include Mongo
    include Constants

    attr_reader :database

    def initialize(database_name,args={})
      args.merge({strict: false}) unless args[:strict]
      if args[:login] && args[:password]
        db = Mongo::Connection.from_uri(MongolabUrl).db(database_name)
        db.authenticate(args[:login],args[:password])
      else
        login, password = 
          File.open(File.join(File.dirname(__FILE__), UserKeyPath ),"r") do |l|
            key = l.readline
            key.chomp!
          end.split '|'
          db = Mongo::Connection.from_uri(MongolabUrl).db(database_name)
          db.authenticate(login,password)
      end
      @database = db
    end

    def collection_names
      collections = []
      @database.collection_names.each do |c|
        puts "#{c} : #{@database.collection(c).count}"
        collections << c
      end
      collections
    end

    def collection collection_name
      @database.collection(collection_name)
    end

    def find_all(collection_name)
      all = []
      collection(collection_name).find.each do |element|
        all << element
      end
      all
    end

    def store(item,collection_name="notes")
      collection = @database.collection(collection_name)
      begin
        id = collection.insert(item.merge({:timestamp => Time.now}))
      rescue Mongo::OperationFailure => failure
        failure
      else
       collection.find("_id" => id).to_a
      end
    end

    def remove(key,value)
      collection.remove(key.intern => value)
    end

    def find(collection,key,value)
      collection.find(key.intern => value).sort(:timestamp => :desc).to_a
    end

    def find_a_set
      # TODO
    end

    def find_with_select
      # TODO
    end

    def find_with_regex
      # TODO
    end

    def update(id, item)
      collection.update({"_id" => id}, doc)
    end

    def update_field(id, key, value)
      collection.update({"_id" => id}, {"$set" => {key.itern => value, :timestamp => Time.now}})
    end

    def geospatial_index(collection)
      collection.create_index([["loc", Mongo::GEO2D]])
      collection.find({"loc" => {"$near" => [50, 50]}}, {:limit => 20}).each do |p|
        puts p.inspect
      end
    end

  end # Api

end # Mongobox
