import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { Gadget, Gadgets } from "@dashkite/talisa"
import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

publish = generic name: "publish"

generic publish,
  ( Gadget.isType "page" ),
  ( target ) -> render target, mode: "publish"

generic publish,
  Type.isString,
  ( Type.isType Gadgets ),
  ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      publish gadget

export default publish
