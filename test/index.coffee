
normat = require '../'
assert = require 'assert'

describe 'normat', ->
  parser = normat [
    ['a', 10]
    ['b', 20]
    ['c', 30]
    ['d']
  ]

  describe 'invalid', ->
    it 'null', ->
      assert.equal null, parser(null)
    it 'false', ->
      assert.equal null, parser(false)
    it 'true', ->
      assert.equal null, parser(true)
    it 'invalid', ->
      assert.equal null, parser('x')
      assert.equal null, parser('')
      assert.equal null, parser('123')
    it 'no arg', ->
      assert.equal null, parser()

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
      base = 200
      assert.equal '19b', parser(base - 1)
      assert.equal '1c',  parser(base)
      assert.equal '1c',  parser(base + 1)
    it 'c -> d', ->
      base = 6000
      assert.equal '29c', parser(base - 1)
      assert.equal '1d',  parser(base)
      assert.equal '1d',  parser(base + 1)
    it 'd -> ~', ->
      base = 6000
      assert.equal '9d',    parser(base * 9)
      assert.equal '10d',   parser(base * 10)
      assert.equal '100d',  parser(base * 100)
      assert.equal '1000d', parser(base * 1000)

  describe 'reverse', ->
    it 'a', ->
      assert.equal 1,   parser('1a')
      assert.equal 100, parser('100a')
    it 'b', ->
      assert.equal 10,   parser('1b')
      assert.equal 1000, parser('100b')
    it 'c', ->
      assert.equal 200,   parser('1c')
      assert.equal 20000, parser('100c')
    it 'd', ->
      assert.equal 6000,   parser('1d')
      assert.equal 600000, parser('100d')