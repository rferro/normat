// normat 1.2.3
// https://github.com/rferro/normat
// Fri, 12 Jun 2015 17:37:03 GMT

(function() {
  "use strict";
  var normat;

  normat = function(opts) {
    var fn;
    fn = function(value) {
      var base, i, j, k, l, label, len, len1, len2, mtp, mtps, ref, ref1, vlabel, vnumber;
      if (typeof value === 'number') {
        value = parseInt(value);
        for (i = j = 0, len = opts.length; j < len; i = ++j) {
          ref = opts[i], label = ref[0], base = ref[1];
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
        for (i = k = 0, len1 = opts.length; k < len1; i = ++k) {
          ref1 = opts[i], label = ref1[0], base = ref1[1];
          if (label === vlabel) {
            if (i === 0) {
              return vnumber;
            } else {
              for (l = 0, len2 = mtps.length; l < len2; l++) {
                mtp = mtps[l];
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

  if (typeof module !== 'undefined') {
    module.exports = normat;
  } else {
    this.normat = normat;
  }

}).call(this);
