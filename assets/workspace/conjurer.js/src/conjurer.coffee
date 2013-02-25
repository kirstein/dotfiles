define [ 'require', 'pubsub' ], (require, PubSub) ->

  class Conjurer extends PubSub

    # Extends object by taking all own properties of the given objects
    # and adding them to temp object.
    extend = (objects...) ->
      obj = {}
      for object in objects
        for own key, value of object
            obj[key] = value
      return obj

    addInitializer : (initializer) ->
      callback = -> initializer.call @, @
      @once @events.START_INIT, callback, @
      return @

    stop  : ->
      # Just ignore if it is not started
      return @ if @_started isnt true
      @trigger @events.STOP, @
      delete @_started
      return @

    start : ->
      # Make sure that start is not called multiple times in row
      # problem is that it will break applications.
      if @_started is true
        throw new Error "Start should not be called multiple times. Forgot to stop?"

      # If loading has not started yet
      # lets start the loading process.
      if @_loading isnt true
        @trigger @events.LOAD_START
        @_loading = true

      # If there are still active loaders lets
      # lets wait for them to finish
      if @_loaders? and @_loaders isnt 0
        # Clear the previous timeout if there is one
        clearTimeout @_startTimout

        fn = => @start.call @
        # Wait 10ms before calling self again
        # 10ms is the minimum reliable timeout time for setTimeout
        callback = => @start.apply @
        @_startTimout = setTimeout callback, 10
        return @

      delete @_loading
      @_started = true

      # Trigger loading done event
      @trigger @events.LOAD_DONE, @
      # Trigger event that actually starts the initiatiors
      @trigger @events.START_INIT, @
      # Trigger the application started event
      @trigger @events.START_DONE, @
      return @

    load : (modules...) ->
      @_loaders or= 0

      successCallback = =>
        @_loaders -= 1
      failureCallback = (error) =>
        @_loaders -= 1
        console.error "Module loading failed", error

      # Build require event for module
      # when the given element is called then the modules will be loaded
      for module in modules
        @_loaders += 1
        @once @events.LOAD_START, -> require [ module ], successCallback, failureCallback

      return @

    addConfig : (key, config) ->
      # If there is no key given, only config object
      # then just extend the app config with that
      if typeof key is 'object'
        @config = extend @config, key

      # If the key is defined then build a new object
      # and add it to config
      else if typeof config is 'object' and key?
        conf      = {}
        conf[key] = config
        return @addConfig conf
      return @

    events :
      LOAD_START : 'app:load:start'
      LOAD_DONE  : 'app:load:done'
      START_DONE : 'app:start:done'
      START_INIT : 'app:start:init'
      STOP       : 'app:stop'