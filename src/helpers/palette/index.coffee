import Producer from "./producer"

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

  from: cache ({ color, specifier... }) ->
    Producer
      .make { color }
      .select specifier

  toCSS: ( palette ) ->
    result = []
    for [ name, { color }] from palette.slots
      if ( palette.get "#{ name }-start" )?
        result.push "--#{ name }-color: #{ color }" 
        result.push "--#{ name }:
          linear-gradient(var(--#{ name }-start), var(--#{ name }-stop))"
      else
        result.push "--#{ name }-color: #{ color }"
        result.push "--#{ name }: var(--#{ name }-color)"

    result.push "color: var(--foreground-color);"
    result.push "background: var(--background);"
    ( result.join "; " ) + ";"


export default Palette