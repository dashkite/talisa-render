import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { Gadgets, Gadget } from "@dashkite/talisa"

import * as Renderers from "../renderers"

render = generic 
  name: "render"
  description: "render a gadget into HTML and CSS"

generic render,
  ( Type.isType Gadget),
  ( gadget ) -> render gadget, {}

generic render,
  ( Type.isType Gadget),
  ( Type.isObject ),
  ( gadget, options ) ->
    if ( renderer = Renderers[ gadget.type ])?
      renderer gadget, options
    else
      console.warn "render: 
        unknown gadget type [ #{ gadget.type } ]"
      undefined

generic render,
  ( Gadget.withTypes Gadget.mixins ),
  ( gadget ) -> undefined

generic render,
  Type.isString,
  ( Type.isType Gadgets ),
  ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      render gadget
    else
      console.warn "render:
        gadget not found: [ #{ key } ]"
      undefined

export default render