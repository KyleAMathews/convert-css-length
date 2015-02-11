# Ported from Compass
# https://github.com/Compass/compass/blob/master/core/stylesheets/compass/typography/_units.scss

parseUnit = require 'parse-unit'
require 'console-polyfill'

baseFontSize = "16px"

# Emulate the sass function "unit"
unit = (length) ->
  parseUnit(length)[1]

# Emulate the sass function "unitless"
unitLess = (length) ->
  parseUnit(length)[0]

# Convert any CSS <length> or <percentage> value to any another.
#
# @param length
#   A css <length> value
#
# @param toUnit
#   String matching a css unit keyword, e.g. 'em', 'rem', etc.
#
# @param fromContext
#   When converting from relative units, the absolute length (in px) to
#   which length refers (e.g. for lengths in em units, would normally be the
#   font-size of the current element).
#
# @param toContext
#   For converting to relative units, the absolute length in px to which the
#   output value will refer. Defaults to the same as fromContext, since it is
#   rarely needed.
module.exports = (baseFontSize=baseFontSize) ->
  return (length, toUnit, fromContext=baseFontSize, toContext=fromContext) ->
    fromUnit = unit(length)

    # Optimize for cases where `from` and `to` units are accidentally the same.
    if fromUnit is toUnit then return length

    # Convert input length to pixels.
    pxLength = unitLess(length)

    # Warn if to or from context aren't in pixels.
    if unit(fromContext) isnt "px"
      console.warn("Parameter fromContext must resolve to a value
        in pixel units.")
    if unit(toContext) isnt "px"
      console.warn("Parameter toContext must resolve to a value
        in pixel units.")

    unless fromUnit is "px"
      if fromUnit is "em"
        pxLength = unitLess(length) * unitLess(fromContext)
      else if fromUnit is "rem"
        pxLength = unitLess(length) * unitLess(baseFontSize)
      else if fromUnit is "ex"
        pxLength = unitLess(length) * unitLess(fromContext) * 2
      else if fromUnit in ["ch", "vw", "vh", "vmin"]
        console.warn "#{fromUnit} units can't be reliably converted; Returning
          original value."
        return length
      else
        console.warn "#{fromUnit} is an unknown or unsupported length unit;
          Returning original value."
        return length

    # Convert length in pixels to the output unit
    outputLength = pxLength
    unless toUnit is "px"
      if toUnit is "em"
        outputLength = (pxLength / unitLess(toContext))
      else if toUnit is "rem"
        outputLength = (pxLength / unitLess(baseFontSize))
      else if toUnit is "ex"
        outputLength = (pxLength / unitLess(toContext) / 2)
      else if toUnit in ["ch", "vw", "vh", "vmin"]
        console.warn "#{toUnit} units can't be reliably converted; Returning
          original value."
        return length
      else
        console.warn "#{toUnit} is an unknown or unsupported length unit;
          Returning original value."
        return length

    return parseFloat(outputLength.toFixed(5)) + toUnit
