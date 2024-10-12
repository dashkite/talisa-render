import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

navigation = ( target ) ->

  HTML.nav ( Attributes.from target ), do ->
    for key in target.content
      render key, target.$

export { navigation }