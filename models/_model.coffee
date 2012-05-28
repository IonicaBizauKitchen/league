class Model
  @_collection: null
  constructor: (attributes) ->
    @attributes = attributes || {}
    
    @id = @attributes._id
    delete @attributes._id if @id
    
    @errors = {}
  
  valid: -> true
  
  persisted: -> @id? and @id != null
  
  full_errors: ->
    ("#{name} #{error}" for name, error of @errors).join(', ')
  
  save: (validate = true) ->
    if not validate or @valid()
      if @persisted()
        @constructor._collection.update(@id, @attributes) 
      else
        @id = @constructor._collection.insert(@attributes)
      
      true
    else
      false
  
  update_attributes: (attrs = {}) ->
    @attributes[key] = value for key, value of attrs
    @save()
  
  update_attribute: (key, value) ->
    attrs = {}
    attrs[key] = value
    @update_attributes(attrs)
  
  destroy: ->
    @constructor._collection.delete(@id) if @persisted
  
  @create: (attrs)->
    record = new this(attrs)
    record.save()
    record