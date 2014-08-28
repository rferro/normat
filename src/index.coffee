
normat = (opts) -> (value) ->
  value = parseInt value

  for opt, i in opts
    label = opt[0]
    base  = opt[1]

    if not base or (i + 1) is opts.length or value < base
      return "#{parseInt(value)}#{label}"

    value = value / base

normat.ms = normat [
  ['ms', 1000]
  ['s',  60]
  ['m',  60]
  ['h',  24]
  ['d',  365]
  ['y']
]

normat.s = normat [
  ['s', 60]
  ['m', 60]
  ['h', 24]
  ['d', 365]
  ['y']
]

normat.m = normat [
  ['m', 60]
  ['h', 24]
  ['d', 365]
  ['y']
]

normat.b = normat [
  ['b',  1024]
  ['kb', 1024]
  ['mb', 1024]
  ['gb', 1024]
  ['tb']
]

normat.kb = normat [
  ['kb', 1024]
  ['mb', 1024]
  ['gb', 1024]
  ['tb']
]

module.exports = normat
