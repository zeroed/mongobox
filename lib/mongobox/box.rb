module Mongobox

  class Box
    
    include Mongo
    include Constants

    attr_reader :database

    def initialize(database_name, args = {}, collection_name = nil)
      args.merge({strict: false}) unless args[:strict]
      db = Mongo::Connection.from_uri(MongolabUrl).db(database_name)
      if args[:login] && args[:password]
        db.authenticate(args[:login],args[:password])
      else
        login, password = 
          File.open(File.join(File.dirname(__FILE__), UserKeyPath ),"r") do |l|
            key = l.readline
            key.chomp!
          end.split '|'
          db.authenticate(login,password)
      end
      @database = db
    end

    def collections
      collections = []
      @database.collection_names.each do |c|
        puts "#{c} : #{@database.collection(c).count}"
        collections << c
      end
      collections
    end

    def collection(collection_name = nil)
      if collection_name
        @collection = @database.collection(collection_name)
      else
        @collection || (raise "collection undefined")
      end
    end

    def store(item)
      begin
        id = collection.insert(item.merge({:timestamp => Time.now}))
      rescue Mongo::OperationFailure => failure
        failure
      else
       collection.find("_id" => id).first
      end
    end

    def remove(key,value)
      collection.remove(key.intern => value)
    end

    def get(id)
      collection.find("_id" => build_id(id_value)).first
    end

    def find(key,value,*fields)
      #TODO :fields => [arg0,arg1...]
      collection.find(key.intern => value).sort(:timestamp => :desc).to_a
    end

    def find_a_set
      # TODO
    end

    def find_with_select
      # TODO
    end

    def find_with_regex(key,query,*options)
      # Regexp::IGNORECASE #=> 1
      # Regexp::EXTENDED #=> 2
      # Regexp::MULTILINE #=> 4
      find(key,Regexp.new(query, options.join('|')))
    end

    def find_all
      all = []
      collection.find.each do |element|
        all << element
      end
      all
    end

    def update(id, item)
      collection.update({"_id" => build_id(id)}, item.merge(:timestamp => Time.now))
    end

    def update_field(id, key, value)
      collection.update({"_id" => build_id(id)}, {"$set" => {key.itern => value, :timestamp => Time.now}})
    end

    def copy(item)
      item['_id'] = nil
      store(item)
    end

    def geospatial_index(collection)
      collection.create_index([["loc", Mongo::GEO2D]])
      collection.find({"loc" => {"$near" => [50, 50]}}, {:limit => 20}).each do |p|
        puts p.inspect
      end
    end

    def build_id id_value
      BSON::ObjectId id_value
    end

    def analize result_of_search
      #TODO
      # each_with_index(*args) { |obj, i| block } -> enum
      # grep(pattern) { |obj| block } -> array
      # inject(initial) { |memo, obj| block } -> obj
      # lazy -> lazy_enumerator
      # map { |obj| block } -> array
    end

  end # Box

end # Mongobox
