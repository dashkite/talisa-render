import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

image = ( target, context ) ->
  HTML.div [
    HTML.picture [
      # TODO shouldn't be necessary to provide a fallback here
      HTML.img src: target.image?.url ? "https://placehold.co/200x150/orange/white"
    ]
  ]

export default image