import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

preview = ( page, context ) ->

  HTML.html [
    HTML.head [
      HTML.title page.title
    ]
    HTML.body do ->
      for gadget in page.content
        render gadget, context
  ]

export default preview