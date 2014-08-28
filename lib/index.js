(function() {
  var normat;

  normat = function(opts) {
    return function(value) {
      var base, i, label, opt, show, _i, _len;
      value = parseInt(value);
      for (i = _i = 0, _len = opts.length; _i < _len; i = ++_i) {
        opt = opts[i];
        label = opt[0];
        base = opt[1];
        show = function() {
          return "" + (parseInt(value)) + label;
        };
        if (!base || (i + 1) === opts.length || value < base) {
          return show();
        }
        value = value / base;
      }
    };
  };

  normat.ms = normat([['ms', 1000], ['s', 60], ['m', 60], ['h', 24], ['d', 365], ['y']]);

  normat.s = normat([['s', 60], ['m', 60], ['h', 24], ['d', 365], ['y']]);

  normat.m = normat([['m', 60], ['h', 24], ['d', 365], ['y']]);

  normat.b = normat([['b', 1024], ['kb', 1024], ['mb', 1024], ['gb', 1024], ['tb']]);

  normat.kb = normat([['kb', 1024], ['mb', 1024], ['gb', 1024], ['tb']]);

  module.exports = normat;

}).call(this);
