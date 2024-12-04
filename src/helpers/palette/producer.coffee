import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as Type from "@dashkite/joy/type"
import * as Colorist from "@dashkite/colorist"
import Gradients from "./gradients"

C = Colorist.color
P = Colorist.palette
S = Colorist.space

L =
  dark:
    min: 0
    max: 0.2
  light:
    min: 0.8
    max: 1

rotate = ( angle, color ) ->
  do Fn.pipe [ 
    C.start color
    C.add "h", angle
  ]

adjust = ( color, intensity ) ->
  do Fn.pipe [
    C.start color
    C.multiply "c", intensity
  ]

_invert =
  dark: ( color ) -> Math.max L.light.min, ( 1 - color.l )
  light: ( color ) -> Math.min L.dark.max, ( 1 - color.l )

invert = ( color, mode ) ->
  do Fn.pipe [
    C.start color
    C.set "l", ( _invert[ mode ] color )
  ]

contrast = ({ background, foreground, highlight, accent }) ->
  ( 60 < ( C.absoluteContrast background, foreground )) &&
    ( 60 < ( C.absoluteContrast background, highlight ))


sort = ( ax ) -> 
  ax.sort ( A, B ) -> A.background.l - B.background.l

generate = ( mode, color ) ->

  highlight = C.clone color
  accent = rotate 15, highlight

  backgrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: L[ mode ].min
      maxLightness: L[ mode ].max
      deltaE: 12

  candidates = []
  for background in backgrounds
    foreground = invert background, mode
    palette = { background, foreground, highlight, accent }
    candidates.push palette

  results = []
  i = 0
  while (( results.length < 5 ) && ( highlight.l < 1 ))
    highlight.set "l", highlight.l + i
    results = candidates.filter contrast
    i = 0.1
  results

  sort results

class Producer

  constructor: ({ @color }) -> @colors = {}
  
  @make: ( specifier ) -> new Producer specifier

  select: ({ mode, gradient, intensity, background }) ->
    
    @colors[ mode ] ?= generate mode, @color
    index = Math.round ( @colors[ mode ].length - 1 ) * background
    colors = @colors[ mode ][ index ]

    palette = do Fn.pipe [
      P.start mode
      P.set "background", adjust colors.background, intensity
      P.set "foreground", adjust colors.foreground, intensity
      P.set "highlight", adjust colors.highlight, intensity 
      P.set "accent", adjust colors.accent, intensity
    ]

    Gradients.addStops {  
      names: [ "highlight", "background" ]
      gradient
      palette
    }

export default Producer
