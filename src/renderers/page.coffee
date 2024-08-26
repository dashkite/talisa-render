import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import * as Verve from "@dashkite/verve"


body = ( target, context ) ->
  for child in target.content
    render child, context

page = ( target, context ) ->

  HTML.html [
    HTML.head [
      HTML.title target.title
    ]
    HTML.body [
      ( body target, context )...
      HTML.style Verve.application
      HTML.style Verve.hints
      HTML.style target.theme
    ]
  ]

export default page