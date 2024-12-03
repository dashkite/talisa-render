import Producer from "./producer"
# import { CanvasImage, getPalette } from "@dashkite/color-thief"
# import families from "./families"

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
    Producer.make state

  from: cache ( state ) ->
    Palette
      .producer state
      .select
        mode: "dark"
        intensity: ( state.intensity / 100 )
        gradient: ( state.gradient / 100 )
        index: state.scheme

  get: ( name, palette ) ->
    palette.get( name ).color.toString()

export default Palette