# convert-css-length
Convert between css lengths e.g. em->px or px->rem

Conversions between em, ex, rem, px are supported. PRs welcome if
you need support for more esoteric length units.

## Install
`npm install convert-css-length`

## Usage
```javascript
var convertLength = require('convert-css-length');

// Set the baseFontSize for your project. Defaults to 16px (also the
browser default).
var convert = convertLength('21px');

// Convert rem to px.
convert('1rem', 'px');
// ---> 16px

// Convert px to em.
convert('30px', 'em');
// ---> 1.875em
```
