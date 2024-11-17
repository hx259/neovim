local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- inline maths
	s({ trig = "mm", snippetType = "snippet" }, fmta("$<>$", i(1))),

	-- begin env
	s(
		{ trig = "beg", snippetType = "snippet" },
		fmta(
			[[
      \begin{<>}
        <>
      \end{<>}
    ]],
			{ i(1), i(2), rep(1) }
		)
	),

	-- equation
	s(
		{ trig = "eq", snippetType = "snippet" },
		fmta(
			[[
      \begin{equation}
        <>
      \end{equation}
    ]],
			i(1)
		)
	),

	-- equation, without numbering
	s(
		{ trig = "eq*", snippetType = "snippet" },
		fmta(
			[[
      \begin{equation*}
        <>
      \end{equation*}
    ]],
			i(1)
		)
	),

	s(
		{ trig = "ml", snippetType = "snippet" },
		fmta(
			[[
      \[
        <>
      \]
    ]],
			i(1)
		)
	),

  -- multiline equations
	s(
		{ trig = "mml", snippetType = "snippet" },
		fmta(
			[[
      \begin{align}
        <>
      \end{align}
    ]],
      i(1)
		)
	),

  -- multiline equations, without numbering
	s(
		{ trig = "mml*", snippetType = "snippet" },
		fmta(
			[[
      \begin{align*}
        <>
      \end{align*}
    ]],
			i(1)
		)
	),

  -- multiline equations, align from the center
	s(
		{ trig = "gather", snippetType = "snippet" },
		fmta(
			[[
      \begin{gather}
        <>
      \end{gather}
    ]],
			i(1)
		)
	),

  -- multiline equations, align from the center, without numbering
	s(
		{ trig = "gather*", snippetType = "snippet" },
		fmta(
			[[
      \begin{gather*}
        <>
      \end{gather*}
    ]],
			i(1)
		)
	),

  -- itemize: with dots
	s(
		{ trig = "itmz", snippetType = "snippet" },
		fmta(
			[[
      \begin{itemize}
        \item <>
      \end{itemize}
    ]],
			i(1)
		)
	),

  -- itemize: with numbers
	s(
		{ trig = "numlis", snippetType = "snippet" },
		fmta(
			[[
      \begin{enumerate}
        \item <>
      \end{enumerate}
    ]],
			i(1)
		)
	),

  -- figure
	s(
		{ trig = "fig", snippetType = "snippet" },
		fmta(
			[[
      \begin{figure}[H]
        \centering
        \includegraphics[width=<>\linewidth]{<>}
        \caption{<>}
      \end{figure}
    ]],
      {i(3),i(1),i(2)}
		)
	),




}
