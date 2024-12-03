import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as Type from "@dashkite/joy/type"
import * as Colorist from "@dashkite/colorist"
import Gradients from "./gradients"

C = Colorist.color
P = Colorist.palette
S = Colorist.space

filter = ({ background, foreground, highlight, accent }) ->
  a = C.absoluteContrast background, foreground
  return if a < 60
    
  b = C.absoluteContrast background, highlight
  return if b < 60
   
  { background, foreground, highlight, accent }

sort = ( ax ) -> 
  ax.sort ( A, B ) ->
    if A.background.l < B.background.l
      -1
    else if A.background.l > B.background.l
      1
    else
      if A.foreground.l < B.foreground.l
        -1
      else if A.foreground.l > B.foreground.l
        1
      else
        if A.highlight.l < B.highlight.l
          -1
        else
          1

createLight = ( color ) ->
  backgrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0.7
      maxLightness: 1
      deltaE: 24
  
  foregrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0
      maxLightness: 1
      deltaE: 24
  
  highlights = S.traceArray
    name: "highlight"
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0.2
      maxLightness: 1
      deltaE: 24

  results = []
  for background in backgrounds
    for foreground in foregrounds
      for highlight in highlights
        colors = filter { background, foreground, highlight }
        if colors?
          results.push colors 
  results

createDark = ( color ) ->
  backgrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0
      maxLightness: 0.3
      deltaE: 24
  
  foregrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0
      maxLightness: 1
      deltaE: 24
  
  highlights = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0
      maxLightness: 1
      deltaE: 24
  
  results = []
  for background in backgrounds
    for foreground in foregrounds
      for highlight in highlights
        colors = filter { background, foreground, highlight }
        if colors?
          results.push colors 
  results

class Producer
  constructor: ({ @color }) ->
    @sweetspot = S.getSweetspot @color
  
  @make: ({ color }) ->
    new Producer color: C.clone color

  Meta.mixin @::, [
    Meta.getters
      light: -> @_light ?= sort createLight @color
      dark: -> @_dark ?= sort createDark @color
  ]

  select: ({ mode, gradient, intensity, index }) ->
    colors = @[ mode ][ index ]

    palette = do Fn.pipe [
      P.start mode
      P.set "base", @color
      P.set "sweetspot", @sweetspot
      P.set "background-start", do Fn.pipe [
        C.start colors.background
        C.multiply "c", intensity
      ]
      P.set "foreground", do Fn.pipe [
        C.start colors.foreground
        C.multiply "c", intensity
      ]
      P.set "highlight-start", do Fn.pipe [
        C.start colors.highlight
        C.multiply "c", intensity
      ]
      P.set "accent", do Fn.pipe [ 
        C.start colors.highlight
        C.add "h", 30
      ]
    ]

    Gradients.addStops {  
      names: [ "highlight", "background" ]
      gradient
      palette
    }

export default Producer
