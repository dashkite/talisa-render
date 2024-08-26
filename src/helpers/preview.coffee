import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { Gadget, Gadgets } from "@dashkite/talisa"
import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

import css from "./gadgets"

body = ( target, context ) ->
  for gadget in target.content
    render gadget, context

preview = generic name: "preview"

generic preview,
  ( Type.isType Gadget ),
  ( Type.isType Gadgets ),
  ( target, context ) ->
    render target, context

generic preview,
  ( Gadget.isType "page" ),
  ( Type.isType Gadgets ),
  ( target, context ) ->
    [
      HTML.style css
      HTML.style target.theme
      HTML.div class: "body",
        body target, context
    ]

generic preview,
  Type.isString,
  ( Type.isType Gadgets ),
  ( key, gadgets ) ->
    if ( target = gadgets.get key )?
      preview target, gadgets

export default preview