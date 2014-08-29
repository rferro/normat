
normat = (opts) ->

  fn = (value) ->
    if typeof value is 'number'
      value = parseInt value

      for opt, i in opts
        label = opt[0]
        base  = parseInt(opt[1])

        if not base or (i + 1) is opts.length or value < base
          return "#{parseInt(value)}#{label}"

        value = value / base
    else
      value = /^([0-9]+)([A-Za-z]+)$/.exec value

      if not value
        return null

      vnumber = parseInt value[1]
      vlabel  = value[2].toLowerCase()
      mtps    = []

      for opt, i in opts
        label = opt[0]
        base  = parseInt(opt[1])

        if label is vlabel
          if i is 0
            return vnumber
          else
            vnumber *= mtp for mtp in mtps
            return vnumber
        else
          mtps.push base

      return null

  fn.opts = opts

  return fn

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
