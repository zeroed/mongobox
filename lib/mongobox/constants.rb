module Mongobox
  module Constants
    UserKeyPath = "config/db-user"
    MongolabUrl = "mongodb://ds051077.mongolab.com:51077"
    ID = "_id"
  end # Constants
  module Exceptions
    NoKeyException = Exception.new "no key found"
end # Mongobox
