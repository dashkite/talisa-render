import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import Attributes from "#helpers/attributes"

container = ( target ) ->

  tag = target.tag ? "div"

  HTML[ tag ] ( Attributes.from target ),
    for key in target.content
      render key, target.$

export { container }