import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

import { marked } from "marked"

text = ( target ) ->
  HTML.div ( Attributes.from target ),
    if target.brief.text?
      HTML.parse marked target.brief.text
    else ""

export { text }