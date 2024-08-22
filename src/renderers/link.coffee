import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

link = ( target, context ) ->
  HTML.a href: target.url, 
    for gadget in target.content
      render gadget, context

export default link