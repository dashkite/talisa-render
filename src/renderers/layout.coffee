import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

layout = ( target, context ) ->

  classes = [
    "layout"
    ( Object.values target.hints )...
  ].join " "

  HTML.div class: classes,
    for gadget in target.content
      render gadget, context

export default layout