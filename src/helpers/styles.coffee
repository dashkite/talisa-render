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

  # TODO can we avoid setting the color/background directly?
  color: ( specifier ) ->
    palette = Palette.from specifier
    background = Palette.get "background", palette
    foreground = Palette.get "foreground", palette
    highlight = Palette.get "highlight", palette
    # TODO generat separate accent color
    accent = Palette.get "highlight", palette
    "--background: #{ background };
    --foreground: #{ foreground };
    --highlight: #{ highlight };
    --accent: #{ accent };
    color: var(--foreground);
    background: var(--background);"

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