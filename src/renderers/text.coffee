import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

import { marked } from "marked"

text = ( target, context ) ->
  HTML.parse marked target.text

export default text