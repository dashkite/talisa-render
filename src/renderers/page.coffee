import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import * as Verve from "@dashkite/verve"

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
      HTML.style Verve.application
      HTML.style Verve.hints
      HTML.style target.theme
    ]
  ]

export { page }