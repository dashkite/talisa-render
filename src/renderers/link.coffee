import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Classes from "#helpers/classes"
import Format from "@dashkite/format-text"
import { Gadgets } from "@dashkite/talisa"

link = ( target ) ->

  # MAYBE this might be how we get the page URL
  # TODO need production / preview variants  
  # url = target.url ? do ->
  #   gadget = target.$.find Gadgets.withName target.page
  #   gadget?.url

  HTML.a 
    name: target.byname
    class: Classes.from target
    href: target.url ? ( "##{ Format.dashed target.page }" if target.page? )
    for key in target.content
      render key, target.$

export { link }