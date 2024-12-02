import { producer as P } from "@dashkite/colorist"
# import { CanvasImage, getPalette } from "@dashkite/color-thief"
import families from "./families"

Cache =

  data: {}

  key: ( specifier ) ->
    JSON.stringify do ->
      Object
        .keys specifier
        .sort() 
        .map ( key ) -> [ key, specifier[ key ]]
  
  get: ( specifier ) -> Cache.data[ Cache.key specifier ]

  put: ( specifier, value ) -> Cache.data[ Cache.key specifier ] = value

cache = ( f ) ->
  ( specifier ) ->
    if ( result = Cache.get specifier )?
      result
    else
      Cache.put specifier, f specifier

Palette =

  producer: ( state ) ->
    # if chroma < 0.2
    #   create grayscale theme
    # else
    base = P.monochromatic.create state.color
    preset = base.selectPreset 
      mode: "dark"
      preset: families.find ( name ) -> name == state.family
    palette = base.select
      mode: "dark"
      intensity: preset.chromaMultiplier
      index: preset.producerIndex
    P.fromPalette.create palette

  from: cache ( state ) ->
    Palette
      .producer state
      .select
        mode: "dark"
        intensity: state.intensity
        index: state.scheme

  get: ( name, palette ) ->
    palette.get( name ).color.toString()

export default Palette