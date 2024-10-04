import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

icon = ( target, context ) ->
  HTML.div class: ( Classes.from target ), [
    HTML.i class: "ri-#{ target.icon }-#{ target.hints.style }"
  ]

export default icon