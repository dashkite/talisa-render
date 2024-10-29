import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"
import  { Gadgets } from "@dashkite/talisa"

Frame =

  preview: ( page, body ) ->
    HTML.div ( Attributes.from page ), body

  publish: ( page, body ) ->
    HTML.html [
      HTML.head [
        # TODO add CSS, page preview, ...
        HTML.title target.title
      ]
      HTML.body ( Attributes.from page ), body
    ]

page = ( target, { mode }) ->
  mode ?= "preview"
  gadgets = target.$
  content = target.content.map ( key ) -> gadgets.get key
  layout = if target.mixins.layout? then gadgets.get target.mixins.layout
  Frame[ mode ] target, do ->
    if layout?
      [ header, main, footer ] = content
      for tag, block of { header, main, footer } when block?
        render block, { tag }
    else
      for gadget in content
        render gadget

export { page }