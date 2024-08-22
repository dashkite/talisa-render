import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

image = ( target, context ) ->
  HTML.picture [
    HTML.img src: target.image.url
  ]

export default image