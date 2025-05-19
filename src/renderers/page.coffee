import { HTML } from "@dashkite/domo"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"
import  { Gadgets } from "@dashkite/talisa"

Frame =

  preview: ( page, body ) ->
    HTML.div ( Attributes.from page ), body

  publish: ( page, body ) ->
    HTML.html [
      HTML.head [
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
      if layout.brief.header
        header = content.shift()
      main = content.shift()
      if layout.brief.aside
        aside = content.shift()
      if layout.brief.footer
        footer = content.shift()

      [
        render header, tag: "header" if header?
        render main, tag: "main"
        render aside, tag: "aside" if aside?
        render footer, tag: "footer" if footer? 
      ]

    else
      for gadget in content
        render gadget

export { page }