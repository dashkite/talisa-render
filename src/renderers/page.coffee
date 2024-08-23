import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import * as Posh from "@dashkite/posh"


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
      HTML.style Posh.application
      HTML.style Posh.hints
      HTML.style target.theme
    ]
  ]

export default page