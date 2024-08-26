import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { Gadgets, Gadget } from "@dashkite/talisa"

import Renderers from "../renderers"


# TODO how to handle errors
#      - not a page gadget
#      - key not found
#      - ...

render = generic 
  name: "render"
  description: "render a Talisa Page Gadget into HTML and CSS"

generic render,
  ( Type.isType Gadget),
  ( Type.isType Gadgets ),
  ( gadget, gadgets ) ->
    if ( renderer = Renderers[ gadget.type ])?
      renderer gadget, gadgets
    else
      Renderers.unknown gadget, gadgets

generic render,
  Type.isString,
  ( Type.isType Gadgets ),
  ( key, gadgets ) ->
    if ( target = gadgets.get key )?
      render target, gadgets

export default render