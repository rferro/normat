(function() {
  var normat;

  normat = function(opts) {
    var fn;
    fn = function(value) {
      var base, i, label, mtp, mtps, vlabel, vnumber, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      if (typeof value === 'number') {
        value = parseInt(value);
        for (i = _i = 0, _len = opts.length; _i < _len; i = ++_i) {
          _ref = opts[i], label = _ref[0], base = _ref[1];
          if (!base || (i + 1) === opts.length || value < base) {
            return "" + (parseInt(value)) + label;
          }
          value = value / base;
        }
      } else {
        value = /^([0-9]+)([A-Za-z]+)$/.exec(value);
        if (!value) {
          return null;
        }
        vnumber = parseInt(value[1]);
        vlabel = value[2].toLowerCase();
        mtps = [];
        for (i = _j = 0, _len1 = opts.length; _j < _len1; i = ++_j) {
          _ref1 = opts[i], label = _ref1[0], base = _ref1[1];
          if (label === vlabel) {
            if (i === 0) {
              return vnumber;
            } else {
              for (_k = 0, _len2 = mtps.length; _k < _len2; _k++) {
                mtp = mtps[_k];
                vnumber *= mtp;
              }
              return vnumber;
            }
          } else {
            mtps.push(base);
          }
        }
        return null;
      }
    };
    fn.opts = opts;
    return fn;
  };

  normat.ms = normat([['ms', 1000], ['s', 60], ['m', 60], ['h', 24], ['d', 365], ['y']]);

  normat.s = normat([['s', 60], ['m', 60], ['h', 24], ['d', 365], ['y']]);

  normat.m = normat([['m', 60], ['h', 24], ['d', 365], ['y']]);

  normat.b = normat([['b', 1024], ['kb', 1024], ['mb', 1024], ['gb', 1024], ['tb']]);

  normat.kb = normat([['kb', 1024], ['mb', 1024], ['gb', 1024], ['tb']]);

  module.exports = normat;

}).call(this);
