import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

image = ( target ) ->
  HTML.div [
    HTML.picture [
      HTML.img
        src: target.brief.image?.url ? 
          "https://placehold.co/200x150/orange/white"
    ]
  ]

export { image }