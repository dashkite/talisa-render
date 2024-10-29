import * as Type from "@dashkite/joy/type"
import Generic from "@dashkite/generic"
import { Mixin, Gadgets, Gadget } from "@dashkite/talisa"

import * as Renderers from "../renderers"

render = Generic.make "Talisa.render"

  .define [ Gadget ], ( gadget ) -> render gadget, {}

  .define [ Gadget, Type.isObject ], ( gadget, options ) ->
    if ( renderer = Renderers[ gadget.type ])?
      renderer gadget, options
    else
      console.warn "render: 
        unknown gadget type [ #{ gadget.type } ]"
      undefined

  .define [ String, Gadgets ], ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      render gadget
    else
      console.warn "render:
        gadget not found: [ #{ key } ]"
      undefined

  .define [ Mixin ], ( gadget ) -> undefined

export default render