import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

navigation = ( target, context ) ->

  HTML.nav do ->
    for gadget in target.content
      render gadget, context

export default navigation