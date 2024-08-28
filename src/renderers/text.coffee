import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

import { marked } from "marked"

text = ( target, context ) ->
  console.log text: target
  HTML.parse marked target.text

export default text