import * as Fn from "@dashkite/joy/function"
import * as Arr from "@dashkite/joy/array"

flatten = ( array ) -> array.flat Infinity
compact = ( array ) -> array.filter ( value ) -> value? && value != ""
join = ( array ) -> array.join "; "

Styles =

  brief: ( value, target ) ->
    for key, _value of value
      if ( resolver = Styles[ key ])?
        resolver _value, target

  color: ( value ) ->
    "--input-color: #{ value }"
  
  mixins: ( mixins ) ->
    join compact do ->
      for mixin in mixins
        Styles.from mixin

  from: ( gadget ) ->
    join compact flatten do ->
      for key, value of gadget
        if ( resolver = Styles[ key ])?
          resolver value, gadget
      
export default Styles