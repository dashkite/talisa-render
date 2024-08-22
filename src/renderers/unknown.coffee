import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

unknown = ( gadget, context ) ->

  HTML.div [
    HTML.header [
      HTML.p "render: unknown gadget type '#{ gadget.type }'"
    ]
    if gadget.content?
      HTML.div do ->
        for child in gadget.content
          render child, context
  ]

export default unknown