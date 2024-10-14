import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

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
  layout = target.mixins.find ( mixin ) -> mixin?.type == "layout"
  Frame[ mode ] target, do ->
    if layout?
      [ header, main, footer ] = target.elements
      # TODO come up with better solution to controlling the tag
      #      ex: render that takes options?
      header.tag = "header"
      main.tag = "main"
      footer.tag = "footer"
      [
        render header
        render main
        render footer
      ]
    else
      for key in target.content
        render key, target.$

export { page }