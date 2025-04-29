import * as Fn from "@dashkite/joy/function"
import * as Arr from "@dashkite/joy/array"

flatten = ( array ) -> array.flat Infinity
compact = ( array ) -> array.filter ( value ) -> value? && value != ""
join = ( array ) -> array.join " "

Classes =

  type: Fn.identity

  subtype: Fn.identity

  hints: ( value, target ) ->
    for key, _value of value
      if ( resolver = Classes[ key ])?
        resolver _value, target

  brief: ( value, target ) ->
    for key, _value of value
      if ( resolver = Classes[ key ])?
        resolver _value, target

  orientation: ( value ) -> value ? "horizontal"

  justification: ( value ) -> "justify-#{ value ? 'start' }"

  alignment: ( value ) -> "align-#{ value ? 'start' }"

  wrap: ( value, target ) -> 
    if value then "wrap"

  proximity: ( value ) ->
    if value != "auto" then value

  width: ( value ) ->
    if value != "auto" then value

  size: ( value ) ->
    if value != "auto" then value

  style: Fn.identity

  border: ( value ) -> "border-#{ value }"

  header: ( value ) -> "header" if value
  footer: ( value ) -> "footer" if value
  aside: ( value ) -> "aside" if value

  mixins: ( mixins, gadget ) ->
    gadgets = gadget.$
    join compact do ->
      for key in Object.values mixins
        Classes.from gadgets.get key

  from: ( gadget ) ->
    join compact flatten do ->
      for key, value of gadget
        if ( resolver = Classes[ key ])?
          resolver value, gadget
      
export default Classes