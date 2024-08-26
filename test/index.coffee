import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"
import * as Type from "@dashkite/joy/type"

import { Gadgets, Gadget } from "@dashkite/talisa"
import esthetic from "esthetic"
import { HTML } from "@dashkite/html-render"

import { render, preview } from "../src/index"
import site from "./site"

gadgets = Gadgets.from site
home = ( gadgets.find Gadget.withByname "home" )

do ->

  print await test "Talisa Render", [

    test "render", ->
      html = HTML.render render home, gadgets
      console.log esthetic.format html, language: "html"

    test "preview", ->
      html = HTML.render preview home, gadgets
      console.log esthetic.format html, language: "html"

  ]

  process.exit if success then 0 else 1
