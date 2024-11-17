local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- upper
  s({ trig = "up", snippetType = "snippet" }, fmta("^{<>}", i(1))),
  s({ trig = "upt", snippetType = "snippet" }, fmta("^{\\text{<>}}", i(1))),
  -- lower
  s({ trig = "dn", snippetType = "snippet" }, fmta("_{<>}", i(1))),
  s({ trig = "dnt", snippetType = "snippet" }, fmta("_{\\text{<>}}", i(1))),
  -- sqrt
  s({ trig = "sqrt", snippetType = "snippet" }, fmta("\\sqrt{<>}", i(1))),
  -- abs
  s({ trig = "abs", snippetType = "snippet" }, fmta("\\abs{<>}", i(1))),
  -- sum
  s({ trig = "sum", snippetType = "snippet" }, fmta("\\sum_{<>}", i(1))),
  -- dot product
  s({ trig = "cd", snippetType = "snippet" }, t("\\cdot")),
  s({ trig = "vd", snippetType = "snippet" }, t("\\vdot")),
  -- approx
  s({ trig = "appr", snippetType = "snippet" }, t("\\approx")),
  -- fraction
  s({ trig = "fk", snippetType = "autosnippet" }, fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  -- reciprocal
  s({ trig = "1/", snippetType = "autosnippet" }, fmta("\\frac{1}{<>}", i(1))),
  -- at
  s({ trig = "at", snippetType = "snippet" }, fmta("\\Big|_{<>}", i(1))),
  -- quad
  s({ trig = "qd", snippetType = "snippet" }, t("\\quad")),
  s({ trig = "qqd", snippetType = "snippet" }, t("\\qquad")),
  -- brackets
  s({ trig = "bb(", snippetType = "snippet" }, fmta("\\Big(<>\\Big)", i(1))),
  s({ trig = "bb{", snippetType = "snippet" }, fmta("\\Big{<>\\Big}", i(1))),
  s({ trig = "lr(", snippetType = "snippet" }, fmta("\\left(<>\\right)", i(1))),
  s({ trig = "lr[", snippetType = "snippet" }, fmta("\\left[<>\\right]", i(1))),
  s({ trig = "lr{", snippetType = "snippet" }, fmta("\\left\\{<>\\right\\}", i(1))),
  -- maths fonts
  s({ trig = "bm", snippetType = "snippet" }, fmta("\\bm{<>}", i(1))),
  s({ trig = "rm", snippetType = "snippet" }, fmta("\\mathrm{<>}", i(1))),
  s({ trig = "bf", snippetType = "snippet" }, fmta("\\mathbf{<>}", i(1))),
  s({ trig = "mc", snippetType = "snippet" }, fmta("\\mathcal{<>}", i(1))),
  s({ trig = "scr", snippetType = "snippet" }, fmta("\\mathscr{<>}", i(1))),
  s({ trig = "te", snippetType = "snippet" }, fmta("\\text{<>}", i(1))),
  -- Real Space
  s({ trig = "RR", snippetType = "snippet" }, t("\\mathbb{R}")),
  -- Order
  s({ trig = "OO", snippetType = "snippet" }, t("\\mathcal{O}")),
  -- imaginary unit
  s({ trig = "ii", snippetType = "snippet" }, t("\\mathrm{i}")),
}
