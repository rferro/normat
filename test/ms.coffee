
normat = require "../"
assert = require "assert"

describe 'ms', ->
  describe 'jumps', ->
    it '0  -> ms', ->
      assert.equal '0ms',   normat.ms(0)
      assert.equal '100ms', normat.ms(100)
      assert.equal '500ms', normat.ms(500)
    it 'ms -> s', ->
      base = 1000
      assert.equal '999ms', normat.ms(base - 1)
      assert.equal '1s',    normat.ms(base)
      assert.equal '1s',    normat.ms(base + 1)
    it 's  -> m', ->
      base = 1000 * 60
      assert.equal '59s', normat.ms(base - 1)
      assert.equal '1m',  normat.ms(base)
      assert.equal '1m',  normat.ms(base + 1)
    it 'm  -> h', ->
      base = 1000 * 60 * 60
      assert.equal '59m', normat.ms(base - 1)
      assert.equal '1h',  normat.ms(base)
      assert.equal '1h',  normat.ms(base + 1)
    it 'h  -> d', ->
      base = 1000 * 60 * 60 * 24
      assert.equal '23h', normat.ms(base - 1)
      assert.equal '1d',  normat.ms(base)
      assert.equal '1d',  normat.ms(base + 1)
    it 'd  -> y', ->
      base = 1000 * 60 * 60 * 24 * 365
      assert.equal '364d', normat.ms(base - 1)
      assert.equal '1y',   normat.ms(base)
      assert.equal '1y',   normat.ms(base + 1)
    it 'y  -> ~', ->
      base = 1000 * 60 * 60 * 24 * 365
      assert.equal '10y',   normat.ms(base * 10)
      assert.equal '100y',  normat.ms(base * 100)
      assert.equal '1000y', normat.ms(base * 1000)
