import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { Gadget, Gadgets } from "@dashkite/talisa"
import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

preview = generic name: "preview"

generic preview,
  ( Type.isType Gadget ),
  ( target ) -> render target, mode: "preview"

generic preview,
  Type.isString,
  ( Type.isType Gadgets ),
  ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      preview gadget

export default preview