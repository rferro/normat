
normat = require "../"
assert = require "assert"

describe 'new parser', ->
  parser = normat [
    ['a', 10]
    ['b', 10]
    ['c', 10]
    ['d', 10]
  ]

  describe 'jumps', ->
    it '0 -> a', ->
      assert.equal '0a', parser(0)
      assert.equal '1a', parser(1)
      assert.equal '5a', parser(5)
    it 'a -> b', ->
      base = 10
      assert.equal '9a', parser(base - 1)
      assert.equal '1b', parser(base)
      assert.equal '1b', parser(base + 1)
    it 'b -> c', ->
      base = 100
      assert.equal '9b', parser(base - 1)
      assert.equal '1c', parser(base)
      assert.equal '1c', parser(base + 1)
    it 'c -> d', ->
      base = 1000
      assert.equal '9c', parser(base - 1)
      assert.equal '1d', parser(base)
      assert.equal '1d', parser(base + 1)
    it 'd -> ~', ->
      base = 1000
      assert.equal '9d',    parser(base * 9)
      assert.equal '10d',   parser(base * 10)
      assert.equal '100d',  parser(base * 100)
      assert.equal '1000d', parser(base * 1000)
