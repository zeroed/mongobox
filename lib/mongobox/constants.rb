# lib/mongobox/constants.rb

module Mongobox

  module Constants
    UserKeyPath = "config/db-user"
    MongolabUrl = "mongodb://ds051077.mongolab.com:51077"
    MongoDefaultLocalhost = "mongodb://localhost:27017"
    ID = "_id"
  end # Constants

  module Exceptions
    NoKeyException = Exception.new "no key found"
  end # Exceptions

end # Mongobox
