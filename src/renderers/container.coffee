import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

container = ( target ) ->

  HTML.div class: ( Classes.from target ),
    for key in target.content
      render key, target.$

export { container }