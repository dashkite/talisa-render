import { HTML } from "@dashkite/html-render"
import render from "#helpers/render"
import * as Posh from "@dashkite/posh"

import theme from "#helpers/theme"

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
      # TODO remove once we have theme support
      HTML.style theme
    ]
  ]

export default page