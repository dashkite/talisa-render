import Generic from "@dashkite/generic"
import { Mixin, Gadgets, Gadget } from "@dashkite/talisa"
import { HTML } from "@dashkite/domo"
import render from "#helpers/render"
import Classes from "#helpers/classes"

publish = Generic.make "publish"

  .define [ Gadget ], ( target ) ->
    render target, mode: "publish"

  .define [ String, Gadgets ], ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      publish gadget

export default publish
