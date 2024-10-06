import * as Fn from "@dashkite/joy/function"
import * as Arr from "@dashkite/joy/array"

flatten = ( array ) -> array.flat Infinity
compact = ( array ) -> array.filter ( value ) -> value?
join = ( array ) -> array.join " "

Classes =

  type: Fn.identity

  subtype: Fn.identity

  hints: ( value, target ) ->
    for key, _value of value
      if ( resolver = Classes[ key ])?
        resolver _value, target

  orientation: ( value ) -> value ? "horizontal"

  justification: ( value ) -> "justify-#{ value ? 'start' }"

  alignment: ( value ) -> "align-#{ value ? 'start' }"

  wrap: ( value ) -> if value then "wrap" else "no-wrap"

  proximity: ( value ) ->
    if value != "auto" then value

  width: ( value ) ->
    if value != "auto" then value

  size: ( value ) ->
    if value != "auto" then value

  style: Fn.identity

  font: ( value ) -> 
    if value?
      { base, heading, copy } = value
      "base-font-#{ base } 
        heading-font-#{ heading} 
        copy-font-#{ copy }"

  color: ( value ) ->
     if value?
      { chroma, hue, lightness } = value
      "chroma-#{ chroma } hue-#{ hue  } #{ lightness }"
  
  mixins: ( value ) ->
    join compact do ->
      for gadget in value
        Classes.from gadget

  from: ( gadget ) ->
    join compact flatten do ->
      for key, value of gadget
        if ( resolver = Classes[ key ])?
          resolver value, gadget
      
export default Classes