# Configure RequireJS
require.config
  baseUrl: '/test'
  urlArgs: "v=" + (new Date()).getTime()
  paths :
    pubsub    : 'vendor/pubsub'
    conjurer  : '../../src/conjurer'


# Require libraries
require ['require', 'vendor/chai', 'vendor/mocha'], (require,chai) ->

  # Chai
  assert = chai.assert
  should = chai.should()
  expect = chai.expect

  # Mocha
  mocha.setup 'bdd'

  # Require base tests before starting
  require [ 'spec/conjurer.test' ], ->
    $ ->
     # Start runner
     mocha.run();


