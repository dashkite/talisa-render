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
  Type.isObject,
  Type.isArray,
  ( target, context ) ->
    render target, context

generic preview,
  ( Gadget.isType "page" ),
  Type.isArray,
  ( target, context ) ->
    [
      HTML.style css
      HTML.style target.theme
      HTML.div class: "body",
        body target, context
    ]

generic preview,
  Type.isString,
  Type.isArray,
  ( key, gadgets ) ->
    if ( target = Gadgets.find key, gadgets )?
      preview target, gadgets

export default preview