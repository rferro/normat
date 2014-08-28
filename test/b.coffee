
normat = require "../"
assert = require "assert"

describe 'b', ->
  describe 'jumps', ->
    it '0  -> b', ->
      assert.equal '0b',   normat.b(0)
      assert.equal '100b', normat.b(100)
      assert.equal '500b', normat.b(500)
    it 'b  -> kb', ->
      base = 1024
      assert.equal '1023b', normat.b(base - 1)
      assert.equal '1kb',   normat.b(base)
      assert.equal '1kb',   normat.b(base + 1)
    it 'kb -> mb', ->
      base = Math.pow(1024, 2)
      assert.equal '1023kb', normat.b(base - 1)
      assert.equal '1mb',    normat.b(base)
      assert.equal '1mb',    normat.b(base + 1)
    it 'mb -> gb', ->
      base = Math.pow(1024, 3)
      assert.equal '1023mb', normat.b(base - 1)
      assert.equal '1gb',    normat.b(base)
      assert.equal '1gb',    normat.b(base + 1)
    it 'gb -> tb', ->
      base = Math.pow(1024, 4)
      assert.equal '1023gb', normat.b(base - 1)
      assert.equal '1tb',    normat.b(base)
      assert.equal '1tb',    normat.b(base + 1)
    it 'tb -> ~', ->
      base = Math.pow(1024, 4)
      assert.equal '10tb',   normat.b(base * 10)
      assert.equal '100tb',  normat.b(base * 100)
      assert.equal '1000tb', normat.b(base * 1000)
      assert.equal '2000tb', normat.b(base * 2000)
