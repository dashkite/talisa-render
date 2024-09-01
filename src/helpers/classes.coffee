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

  from: ( target ) ->
    join compact flatten do ->
      for key, value of target
        if ( resolver = Classes[ key ])?
          resolver value, target
      
export default Classes