import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

preview = ( page, context ) ->
  HTML.div class: "preview",
    for gadget in page.content
      render gadget, context

export default preview