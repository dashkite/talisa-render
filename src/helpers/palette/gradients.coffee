import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as Type from "@dashkite/joy/type"
import * as Colorist from "@dashkite/colorist"

C = Colorist.color
P = Colorist.palette
S = Colorist.space

_distance = ( reference ) ->
  ( color ) ->
    reference.distance color, "oklch"

sort = ( color, ax ) ->
  distance = _distance color
  ax.sort ( A, B ) ->
    if A.l < B.l
      -1
    else if A.l > B.l
      1
    else
      if (distance A) < (distance B)
        -1
      else
        1

createSpace = ( color ) ->
  traces = {}

  high = S.searchDimension "c", 0, do Fn.pipe [
    C.start color
    C.multiply "c", 1.1
  ]

  traces.color = S.traceArray
    type: "perturbation"
    options:
      color: C.clone color
      dimension: "c"
      low: 0.9 * color.c
      high: high.c
      deltaE: 4

  high = 1.1 * color.l
  high = 1 if high > 1

  traces.light = S.traceArray
    type: "perturbation"
    options:
      color: C.clone color
      dimension: "l"
      low: 0.9 * color.l
      high: high
      deltaE: 4

  traces.hue = S.traceArray
    type: "perturbation"
    options:
      color: C.clone color
      dimension: "h"
      low: color.h - 36
      high: color.h + 36
      deltaE: 4
  
  results = []
  for light in traces.light
    for color in traces.color
      for hue in traces.hue
        results.push C.p3 C.create [ light.l, color.c, hue.h ]

  console.log "gradient space size #{results.length}"
  results



class Producer
  # constructor: ({ @color }) ->
  
  # @make: ({ color }) ->
  #   new Producer color: C.clone color

  # Meta.mixin @::, [
  #   Meta.getters
  #     space: -> @_space ?= sort @color, createSpace @color
  # ]

  # select: ( gradient ) ->
  #   index = Math.round ( @space.length - 1 ) * gradient
  #   @space[ index ]

  @addStop: ({ name, gradient, palette }) ->
    start = ( palette.get name ).color
    adjustment = gradient * ( if ( start.l >= 0.8 ) then -0.2 else 0.2 )
    stop = do Fn.pipe [
      C.start start
      C.set "l", start.l + adjustment
    ]
    console.log { start, stop }
    P.set "#{ name }-start", start, palette
    P.set "#{ name }-stop", stop, palette
    palette

  @addStops: ({ names, gradient, palette }) ->
    for name in names
      @addStop { name, gradient, palette }
    palette

export default Producer
