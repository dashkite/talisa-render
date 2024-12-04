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
    background = 
      color: Palette.get "background", palette
      start: Palette.get "background-start", palette
      stop: Palette.get "background-stop", palette
    foreground = Palette.get "foreground", palette
    highlight = 
      color: Palette.get "highlight", palette
      start: Palette.get "highlight-start", palette
      stop: Palette.get "highlight-stop", palette
    # TODO generat separate accent color
    accent = Palette.get "accent", palette
    "--background-color:#{ background.color };
      --background: linear-gradient(#{ background.start }, #{ background.stop });
      --foreground: #{ foreground };
      --highlight-color: #{ highlight.color };
      --highlight: linear-gradient(#{ highlight.start }, #{ highlight.stop });
      --accent: #{ highlight.start };
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