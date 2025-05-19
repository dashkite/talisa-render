import { HTML } from "@dashkite/domo"
import render from "#helpers/render"
import Classes from "#helpers/classes"
import Format from "@dashkite/format-text"
import { Gadgets } from "@dashkite/talisa"

link = ( target ) ->

  # MAYBE this might be how we get the page URL
  { url, page } = target.brief

  HTML.a 
    name: target.byname
    class: Classes.from target
    href: if url?
      url
    else if page?
      "/#{ Format.dashed page }"
    else
      "#"
    for key in target.content
      render key, target.$

export { link }