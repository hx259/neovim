local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- hat
	s({ trig = "hat", snippetType = "snippet" }, fmta("\\hat{<>}",i(1)) ),
  -- bar
	s({ trig = "bar", snippetType = "snippet" }, fmta("\\bar{<>}",i(1)) ),
  -- tilde
	s({ trig = "tilde", snippetType = "snippet" }, fmta("\\tilde{<>}",i(1)) ),
  -- dagger
	s({ trig = "dag", snippetType = "snippet" }, fmta("\\hat{<>}^{\\dagger}",i(1)) ),
  -- bra-ket
	s({ trig = ";la", snippetType = "snippet" }, t("\\langle")),
	s({ trig = ";ra", snippetType = "snippet" }, t("\\rangle")),
	s({ trig = ";lra", snippetType = "snippet" }, fmta("\\langle <>|<>|<> \\rangle", {i(1),i(2),i(3)}) ),
	-- s({ trig = "bra", snippetType = "snippet" }, fmta("\\bra{<>}", i(1)) ),
	-- s({ trig = "ket", snippetType = "snippet" }, fmta("\\ket{<>}", i(1)) ),
	-- s({ trig = "braket", snippetType = "snippet" }, fmta("\\braket{<>}", i(1)) ),
	-- s({ trig = "Braket", snippetType = "snippet" }, fmta("\\Braket{<>}", i(1)) ),
  -- vacuum expectation value
	s({ trig = "vev", snippetType = "snippet" }, fmta("\\langle 0|<>|0 \\rangle", i(1)) ),
  -- normal ordering
	s({ trig = ";no", snippetType = "autosnippet" }, fmta("\\{<>\\}", i(1)) ),
  -- derivatives
	s({ trig = ";del", snippetType = "snippet" }, t("\\nabla") ),
	s({ trig = "dd", snippetType = "snippet" }, t("\\dd") ),
	s({ trig = ";dv", snippetType = "snippet" }, fmta("\\frac{\\dd <>}{\\dd <>}",{i(1),i(2)} )),
  -- deri operators
	s({ trig = "grad", snippetType = "snippet" }, t("\\grad") ),
	s({ trig = "div", snippetType = "snippet" }, t("\\div") ),
	s({ trig = "curl", snippetType = "snippet" }, t("\\curl") ),
  -- partial derivative
	s({ trig = ";par", snippetType = "snippet" }, t("\\partial") ),
	s({ trig = ";pdv", snippetType = "snippet" }, fmta("\\frac{\\partial <>}{\\partial <>}",{i(1),i(2)} )),
  -- effective Hamiltonian
	s({ trig = ";HH", snippetType = "snippet" }, t("\\bar{H}") ),
  -- Lagrangian
	s({ trig = ";LL", snippetType = "snippet" }, t("\\mathcal{L}") ),
  -- wick
	s({ trig = "wick", snippetType = "snippet" }, fmta("\\wick[sep=0.35em]{<>}", i(1)) ),
	s({ trig = "wick1", snippetType = "snippet" }, fmta("\\wick[sep=0.35em]{\\c1{<>}\\c1{<>}}", {i(1),i(2)} )),
	s({ trig = "wick2", snippetType = "snippet" }, fmta("\\wick[sep=0.35em]{\\c2{<>}\\c1{<>}\\c<>{<>}\\c<>{<>}}", {i(1),i(2),i(3),i(4),i(5),i(6)} )),
	s({ trig = "c1", snippetType = "snippet" }, fmta("\\c1{<>}<>", {i(1),i(2)}) ),
	s({ trig = "c2", snippetType = "snippet" }, fmta("\\c2{<>}<>", {i(1),i(2)}) ),
	s({ trig = "c3", snippetType = "snippet" }, fmta("\\c3{<>}<>", {i(1),i(2)}) ),
	s({ trig = "c4", snippetType = "snippet" }, fmta("\\c4{<>}<>", {i(1),i(2)}) ),
}
