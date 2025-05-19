import Generic from "@dashkite/generic"
import { Mixin, Gadgets, Gadget } from "@dashkite/talisa"
import { HTML } from "@dashkite/domo"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

preview = Generic.make "preview"

  .define [ Gadget ], ( target ) ->
    render target, mode: "preview"

  .define [ String, Gadgets ], ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      preview gadget

export default preview