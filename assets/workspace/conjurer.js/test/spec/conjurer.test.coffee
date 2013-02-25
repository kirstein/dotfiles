define [ 'conjurer' ], (Conjurer) ->

  describe "Conjurer", ->
    conjurer = null
    beforeEach -> conjurer = new Conjurer

    it "should exist", ->
      Conjurer.should.exist

    describe "events published on start", ->
      it "should publish 'app:load:start' event", (done) ->
        conjurer.on 'app:load:start', -> done()
        conjurer.start()

      it "should publish 'app:load:done' event", (done) ->
        conjurer.on 'app:load:done', -> done()
        conjurer.start()

      it "should publish 'app:start:done' event", (done) ->
        conjurer.on 'app:start:done', -> done()
        conjurer.start()

      it "should publish 'app:start:init' event", (done) ->
        conjurer.on 'app:start:init', -> done()
        conjurer.start()

    describe "chainability", ->
      it "#addConfig should be chainable", ->
        conjurer.addConfig({}).should.equal conjurer

      it "#addInitializer should be chainable", ->
        conjurer.addInitializer(->).should.equal conjurer

      it "#load should be chainable", ->
        conjurer.load('dont').should.equal conjurer

      it "#stop should be chainable", ->
        conjurer.stop().should.equal conjurer

    describe "#addConfig", ->
      it "should exist", ->
        conjurer.addConfig.should.be.defined

      it "should add configure rules", ->
        conjurer.addConfig { test : 'key' }
        conjurer.config.should.eql { test : 'key' }

      it "should add configure rules under defined certain key", ->
        conjurer.addConfig 'random.key', { 'test' : 'random' }
        conjurer.config.should.eql { 'random.key' : { 'test' : 'random' }}

      it "should extend config rules", ->
        conjurer.addConfig { test : 'key', quick : 'fox' }
        conjurer.config.should.eql { test : 'key', quick : 'fox' }
        conjurer.addConfig { test : 'new', random : true }
        conjurer.config.should.eql { test : 'new', random : true, quick : 'fox' }

      it "should extend config rules defined with a certain key", ->
        conjurer.addConfig { test : 'key', quick : 'fox' }
        conjurer.config.should.eql { test : 'key', quick : 'fox' }
        conjurer.addConfig 'new', { test : 'new' }
        conjurer.config.should.eql { test : 'key', quick : 'fox', 'new' : { test : 'new' } }

    describe "#addInitializer", ->
      it "should exist", ->
        conjurer.addInitializer.should.be.defined

      it "should add initializers and initialize them", (done) ->
        initializer = (conjurer) ->
          conjurer.should.equal conjurer
          done()

        conjurer.addInitializer initializer
        conjurer.start()

    describe "#load", ->
      it "should exist", ->
        conjurer.load.should.be.defined

      it "should load resource", (done) ->
        conjurer.once conjurer.events.START_DONE, -> done()
        conjurer.load 'conjurer'
        conjurer.start()

      it "should load multiple resources given with arguments", (done) ->
        conjurer.once conjurer.events.START_DONE, -> done()
        conjurer.load 'conjurer'
        conjurer.load 'mocha'
        conjurer.start()

      it "should load multiple resources and start the application, no matter if resources fail", (done) ->
        conjurer.once conjurer.events.START_DONE, -> done()
        conjurer.load 'fail1'
        conjurer.load 'conjurer'
        conjurer.start()

    describe "#start", ->
      it "should exist", ->
        conjurer.start.should.be.defined

      it "should throw when app is already started", ->
        conjurer.start()
        (-> conjurer.start()).should.throw "Start should not be called multiple times. Forgot to stop?"

    describe "#stop", ->
      it "should publish stop event", (done) ->
        conjurer.on 'app:stop', -> done()
        conjurer.start()
        conjurer.stop()

      it "should not publish an event if start was not previously called", (done) ->
        conjurer.on 'app:stop', -> throw new Error "Should not reach"
        conjurer.stop()
        setTimeout done, 100

      it "should allow calling start again", ->
        conjurer.start()
        conjurer.stop()
        ( -> conjurer.start()).should.not.throw
