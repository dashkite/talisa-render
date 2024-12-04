import * as Fn from "@dashkite/joy/function"
import * as Arr from "@dashkite/joy/array"
import Palette from "./palette"

flatten = ( array ) -> array.flat Infinity
compact = ( array ) -> array.filter ( value ) -> value? && value != ""
join = ( array ) -> array.join "; "

Styles =

  brief: ( value, target ) ->
    for key, _value of value
      if ( resolver = Styles[ key ])?
        resolver _value, target

  color: ( specifier ) ->
    # TODO remove once we get this from the app
    specifier.mode ?= "dark"
    Palette.toCSS Palette.from specifier
    
  fonts: ({ heading, copy, base }) ->
    "--heading-font: '#{ heading }';
      --copy-font: '#{ copy }';
      --base-font: '#{ base }'"
  
  mixins: ( mixins, gadget ) ->
    gadgets = gadget.$
    join compact do ->
      for mixin in Object.values mixins
        Styles.from gadgets.get mixin

  from: ( gadget ) ->
    join compact flatten do ->
      for key, value of gadget
        if ( resolver = Styles[ key ])?
          resolver value, gadget
      
export default Styles