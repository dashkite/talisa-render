import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as Type from "@dashkite/joy/type"
import * as Colorist from "@dashkite/colorist"
import Gradients from "./gradients"

C = Colorist.color
P = Colorist.palette
S = Colorist.space

rotate = ( angle, color ) ->
  do Fn.pipe [ 
    C.start color
    C.add "h", angle
  ]

filter = ({ background, foreground, highlight, accent }) ->
  a = C.absoluteContrast background, foreground
  return false if a < 60
    
  # b = C.absoluteContrast background, highlight
  # return false if b < 60
   
  true

sort = ( ax ) -> 
  ax.sort ( A, B ) ->
    if A.background.l < B.background.l
      -1
    else if A.background.l > B.background.l
      1
    else
      0

createLight = ( color ) ->
  backgrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0.7
      maxLightness: 1
      deltaE: 24
  
  # foregrounds = S.traceArray
  #   type: "LCSweetspot"
  #   options:
  #     color: C.clone color
  #     chromaRatio: 1
  #     minLightness: 0
  #     maxLightness: 1
  #     deltaE: 24
  
  # highlights = S.traceArray
  #   name: "highlight"
  #   type: "LCSweetspot"
  #   options:
  #     color: C.clone color
  #     chromaRatio: 1
  #     minLightness: 0.2
  #     maxLightness: 1
  #     deltaE: 24

  results = []
  for background in backgrounds
    foreground = rotate 180, background
    highlight = rotate 30, foreground
    accent = rotate 30, highlight
    palette = { background, foreground, highlight, accent }
    if ( filter palette )
      results.push palette 
  results

createDark = ( color ) ->
  backgrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: 0
      maxLightness: 0.3
      deltaE: 12
  
  # foregrounds = S.traceArray
  #   type: "LCSweetspot"
  #   options:
  #     color: C.clone color
  #     chromaRatio: 1
  #     minLightness: 0
  #     maxLightness: 1
  #     deltaE: 12
  
  # highlights = S.traceArray
  #   type: "LCSweetspot"
  #   options:
  #     color: C.clone color
  #     chromaRatio: 1
  #     minLightness: 0
  #     maxLightness: 1
  #     deltaE: 24
  
  # results = []
  # for background in backgrounds
  #   for foreground in foregrounds
  #     for highlight in highlights
  #       colors = filter { background, foreground, highlight }
  #       if colors?
  #         results.push colors 
  # results

  results = []
  foreground = do Fn.pipe [
    C.start color
    C.set "l", Math.max 0.9, color.l
  ]
  highlight = rotate 15, foreground
  accent = rotate 15, highlight
  for background in backgrounds
    palette = { background, foreground, highlight, accent }
    results.push palette if filter palette
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

    base = @[ mode ]

    index = Math.round ( base.length - 1 ) * index

    console.log { index, base }

    colors = base[ index ]

    palette = do Fn.pipe [
      P.start mode
      P.set "base", @color
      P.set "sweetspot", @sweetspot
      P.set "background", do Fn.pipe [
        C.start colors.background
        C.multiply "c", intensity
      ]
      P.set "foreground", do Fn.pipe [
        C.start colors.foreground
        C.multiply "c", intensity
      ]
      P.set "highlight", do Fn.pipe [
        C.start colors.highlight
        C.multiply "c", intensity
      ]
      P.set "accent", do Fn.pipe [ 
        C.start colors.accent
        C.multiply "c", intensity
      ]
    ]

    Gradients.addStops {  
      names: [ "highlight", "background" ]
      gradient
      palette
    }

export default Producer
