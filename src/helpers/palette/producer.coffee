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


sort = ( mode, palettes ) ->
  if mode == "dark"
    palettes.sort ( A, B ) -> A.background.l - B.background.l
  else
    palettes.sort ( A, B ) -> B.background.l - A.background.l

reverse = ( mode ) -> if mode == "dark" then "light" else "dark"

generate = ( mode, color ) ->

  backgrounds = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: L[ mode ].min
      maxLightness: L[ mode ].max
      deltaE: 12

  highlights = S.traceArray
    type: "LCSweetspot"
    options:
      color: C.clone color
      chromaRatio: 1
      minLightness: L[ reverse mode ].min
      maxLightness: L[ reverse mode ].max
      deltaE: 12

  results = []
  for background in backgrounds
    foreground = invert background, mode
    for highlight in highlights
      accent = rotate 15, highlight
      palette = { background, foreground, highlight, accent }
      results.push palette if contrast palette
  sort mode, results

class Producer

  constructor: ({ color }) ->
    @color = C.create "oklch(66.66% .1 #{ color })"
    @colors =
      light: generate "light", @color
      dark: generate "dark", @color

  @make: ( specifier ) -> new Producer specifier

  getPalette: ( mode, background ) ->
    palettes = @colors[ mode ]
    index = Math.round ( palettes.length - 1 ) * background
    palettes[ index ]

  select: ({ gradient, intensity, background }) ->
    
    colors = 
      light: @getPalette "light", background
      dark: @getPalette "dark", background

    palette = do Fn.pipe [
      P.start "colors"
      P.set "light-background", adjust colors.light.background, intensity
      P.set "light-foreground", adjust colors.light.foreground, intensity
      P.set "light-highlight", adjust colors.light.highlight, intensity 
      P.set "light-accent", adjust colors.light.accent, intensity
      P.set "dark-background", adjust colors.dark.background, intensity
      P.set "dark-foreground", adjust colors.dark.foreground, intensity
      P.set "dark-highlight", adjust colors.dark.highlight, intensity 
      P.set "dark-accent", adjust colors.dark.accent, intensity
    ]

    Gradients.addStops {  
      names: [
        "light-highlight"
        "light-background"
        "dark-highlight"
        "dark-background"
      ]
      gradient
      palette
    }

export default Producer
