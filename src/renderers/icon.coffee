import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

import { marked } from "marked"

icon = ( target, context ) ->
  HTML.i class: "ri-#{ target.icon }-#{ target.hints.style }"

export default icon