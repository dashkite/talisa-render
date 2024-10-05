import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"

link = ( target ) ->
  HTML.a 
    name: target.byname
    class: Classes.from target
    href: target.url
    for key in target.content
      render key, target.$

export { link }