#import "@preview/numberingx:0.0.1": formatter
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let shared(doc) = {
  show outline.entry: it => {
    let el = it.element
    let lvl = it.level
    let supp = el.supplement

    if state("appendix", false).at(it.element.location()) {
      if (it.level == 1) {
        link(
          el.location(),
          it.indented([Приложение ] + it.prefix(), it.inner()),
        )
      }
    } else { it }
  }


  show: codly-init.with()
  codly(
    languages: codly-languages,
    zebra-fill: none,
    display-icon: false,
    breakable: true,
    smart-indent: true,
    stroke: 0.5pt + rgb("#2c2c2c"),
  )

  show figure.where(kind: raw): set block(breakable: true)
  show figure.where(kind: table): set block(breakable: true)


  set enum(full: true)
  set enum(numbering: formatter("{decimal}.{lower-russian}."))
  set math.equation(numbering: "(1)")

  set bibliography(style: "gost-r-705-2008-numeric", title: "Список использованных источников")
  set outline(depth: 2)

  doc
}

#let final(font-size: 14pt, doc) = {
  show: shared

  set page(
    paper: "a4",
    margin: (left: 30mm, right: 10mm, y: 20mm),
  )

  set text(font: "Times New Roman", size: font-size, lang: "ru")
  show raw: set text(font: "Menlo", lang: "en")

  set par(
    leading: 1em,
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set heading(numbering: "1.")
  show heading: set align(center)
  show heading: set text(size: font-size)


  show heading: set block(below: 1.2em)
  // show heading: set block(stroke: 0.5pt + rgb("#2c2c2c"))

  show heading.where(level: 1): it => upper()[#it]
  show heading.where(level: 3): it => {
    emph[#block(above: 1.2em)[#it]]
  }

  show heading.where(level: 4): it => {
    set align(left)
    block(above: 1.2em)[#it.body]
  }

  show figure.where(kind: table): set figure.caption(position: top)
  show table: set par(leading: 0.6em, justify: false)


  show figure.caption: set text(size: font-size - 1pt)
  doc
}

#let normal(font-size: 12pt, doc) = {
  show: shared

  set page(
    paper: "a4",
    margin: 2cm,
  )

  set heading(numbering: "1.")


  set par(
    leading: 0.6em,
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set text(font: "Times New Roman", size: font-size, lang: "ru")
  show raw: set text(font: "Menlo", lang: "en")

  set table(stroke: 0.5pt + rgb("#2c2c2c"))
  doc
}

#let annexes(content) = {
  [#none <annexes>]

  set heading(
    numbering: formatter("{upper-russian}.{decimal}."),
    hanging-indent: 0pt,
    supplement: [Приложение],
  )

  show heading.where(level: 1): it => {
    set align(right)
    block[
      #upper([приложение]) #numbering(it.numbering, ..counter(heading).at(it.location()))\
      #text(weight: "medium")[#it.body]
    ]
  }

  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    counter("appendix").step()

    pagebreak(weak: true)
    it
  }

  state("appendix").update(true)
  counter(heading).update(0)
  content
}
