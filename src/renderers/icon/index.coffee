import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

import names from "./names"

icon = ( target ) ->
  
  { brief } = target

  name = if brief.icon in names
    brief.icon
  else
    "#{ brief.icon }-#{ brief.style }"

  HTML.div class: ( Classes.from target ), [
    HTML.i class: "ri-#{ name }"
  ]

export { icon }