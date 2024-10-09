import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"

# TODO add classes

body = ( target ) ->
  for key in target.content
    render child, target.$

page = ( target ) ->

  HTML.html [
    HTML.head [
      HTML.title target.title
    ]
    HTML.body [
      ( body target )...
    ]
  ]

export { page }