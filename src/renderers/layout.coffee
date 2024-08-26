import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

layout = ( target, context ) ->

  HTML.div class: ( Classes.from target ),
    for gadget in target.content
      render gadget, context

export default layout