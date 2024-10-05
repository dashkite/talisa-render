import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

navigation = ( target ) ->

  HTML.nav do ->
    for key in target.content
      render key, target.$

export { navigation }