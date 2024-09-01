import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

import { marked } from "marked"

text = ( target, context ) ->
  HTML.div ( Attributes.from target ),
    HTML.parse marked target.text

export default text