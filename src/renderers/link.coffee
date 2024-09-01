import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

link = ( target, context ) ->
  HTML.a 
    name: target.byname
    class: Classes.from target
    href: target.url
    for gadget in target.content
      render gadget, context

export default link