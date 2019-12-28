# normat

generic javascript number/string formatting (bytes, milliseconds...)

[![NPM](https://nodei.co/npm/normat.png)](https://nodei.co/npm/normat/)

## Install

```shell
npm install normat
```

or

```shell
bower install normat
```

## Examples

```js
var normat = require("normat")
var ms = normat.ms;
var b  = normat.b;
```
```js
// milliseconds parser

ms(123);                        // 123 ms
ms(1000);                       // 1 s
ms(10000);                      // 10 s
ms(1000 * 60 * 60 * 12);        // 12 h
ms(1000 * 60 * 60 * 24 * 1500); // 4 y
```
```js
// bytes parser

b(123);                         // 123 b
b(1024);                        // 1 kb
b(10240);                       // 10 kb
b(100000);                      // 97 kb
b(123123124);                   // 117 mb
b(1231423525142134);            // 1119 tb
```
```js
// seconds parser

normat.s()
```
```js
// minutes parser

normat.m()
```
```js
// kbytes parser

normat.kb()
```

## Create new parsers

```js
var normat = require("normat");

var my_parser = normat([
  ['u',  10],
  ['d',  10],
  ['c',  10],
  ['m',  1000],
  ['mi', 1000],
  ['b',  1000],
  ['t']
]);

my_parser(1);           // 1 u
my_parser(10);          // 1 d
my_parser(100);         // 1 c
my_parser(1000);        // 1 m
my_parser(1000000);     // 1 mi
my_parser(2000000);     // 2 mi
my_parser(10000000);    // 10 mi
my_parser(100000000);   // 100 mi
my_parser(9900000000);  // 9 b
my_parser(19000000000); // 19 b
```
```js
// bytes

b = normat ([
  ['b',  1024]
  ['kb', 1024]
  ['mb', 1024]
  ['gb', 1024]
  ['tb']
]);
```
```js
// milliseconds

ms = normat([
  ['ms', 1000]
  ['s',  60]
  ['m',  60]
  ['h',  24]
  ['d',  365]
  ['y']
]);
```

## Reverse Mode

```js
var normat = require("normat");

var my_parser = normat([
  ['u',  10],
  ['d',  10],
  ['c',  10],
  ['m',  1000],
  ['mi', 1000],
  ['b',  1000],
  ['t']
]);

my_parser('1u');      // 1
my_parser('1d');      // 10
my_parser('1c');      // 100
my_parser('1m');      // 1000
my_parser('1mi');     // 1000000
```

## Tests

```shell
gulp test
```

## License

MIT
