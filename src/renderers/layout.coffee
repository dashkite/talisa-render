import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

Classes =

  from: ( target ) ->

    result = [ target.type ]
    result.push target.hints.orientation ? "horizontal"
    result.push "justify-" + ( target.hints.justification ? "start" )
    result.push "align-" + ( target.hints.alignment ? "start" )
    if target.hints.wrap? && target.hints.wrap
      result.push "wrap"
    else
      result.push "no-wrap"
    if ( target.hints.proximity? ) && ( target.hints.proximity != "auto" )
      result.push target.hints.proximity
    if ( target.hints.width? ) && ( target.hints.width != "auto" )
      result.push target.hints.width
    result.join " "


layout = ( target, context ) ->

  HTML.div class: ( Classes.from target ),
    for gadget in target.content
      render gadget, context

export default layout