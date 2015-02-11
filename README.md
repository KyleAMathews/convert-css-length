# convert-css-length
Convert between css lengths e.g. em->px or px->rem

Conversions between em, ex, rem, px are supported. PRs welcome if
you need support for more esoteric length units.

*[Note: algorithm was originally ported from Compass] (https://github.com/Compass/compass/blob/master/core/stylesheets/compass/typography/_units.scss)*

## Install
`npm install convert-css-length`

## Usage
```javascript
var convertLength = require('convert-css-length');

// Set the baseFontSize for your project. Defaults to 16px (also the
// browser default).
var convert = convertLength('21px');

// Convert rem to px.
convert('1rem', 'px');
// ---> 16px

// Convert px to em.
convert('30px', 'em');
// ---> 1.875em

// Convert em to pixels using fromContext (1em is relative to the
// font-size of its element so if using converting from em
// (btw, rem is awesome and completely solves this problem) you need to
// set the font-size of element you're converting from.).
convert('1em', 'px', '14px')
// ---> 14px
```
