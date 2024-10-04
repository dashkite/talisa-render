import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

import { marked } from "marked"

text = ( target, context ) ->
  HTML.div ( Attributes.from target ),
    if target.text?
      HTML.parse marked target.text
    else ""

export default text