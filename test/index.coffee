import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"
import * as Type from "@dashkite/joy/type"

import { Gadgets, Gadget } from "@dashkite/talisa"
import esthetic from "esthetic"
import { HTML } from "@dashkite/domo"

import { render, preview } from "../src/index"

import site from "./site"
import expect from "./expect"

gadgets = Gadgets.from site
[ home ] = gadgets.pages

do ->

  print await test "Talisa Render", [

    test "render", ->
      html = HTML.render render home
      assert.equal expect.render,
        esthetic.format html, language: "html"

    test "preview", ->
      html = HTML.render preview home
      assert.equal expect.preview,
        esthetic.format html, language: "html"

  ]

  process.exit if success then 0 else 1
