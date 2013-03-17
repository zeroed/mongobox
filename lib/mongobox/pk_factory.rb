module Mongobox
  class PKFactory 
    def create_pk(doc) 
      return doc if doc[:_id] 
      doc.delete(:_id) # in case it exists but the value is nil 
      doc['_id'] ||= BSON::ObjectId.new doc 
    end 
  end # PKFactory
end #Mongobox 
