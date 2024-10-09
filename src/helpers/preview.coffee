import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { Gadget, Gadgets } from "@dashkite/talisa"
import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

body = ( target ) ->
  for key in target.content
    render key, target.$

preview = generic name: "preview"

generic preview,
  ( Type.isType Gadget ),
  ( target ) -> render target

generic preview,
  ( Gadget.isType "page" ),
  ( target ) ->
    classes = Classes.from target
    [
      HTML.style target.css if target.css?
      HTML.div class: "body #{ classes }", body target
    ]

generic preview,
  Type.isString,
  ( Type.isType Gadgets ),
  ( key, gadgets ) ->
    if ( gadget = gadgets.get key )?
      preview gadget

export default preview