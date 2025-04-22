#import "@preview/numberingx:0.0.1": formatter

#let final(font-size: 14pt, doc) = {
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

  show heading.where(level: 1): it => block(above: 3em)[#upper()[#it]]
  show heading.where(level: 2): it => block(above: 2em)[#it]
  show heading.where(level: 3): it => {
    set text(weight: "regular")
    block(above: 2em)[#it.body]
  }

  set enum(full: true)
  set enum(numbering: formatter("{decimal}.{lower-russian}."))

  show figure.caption: set text(size: font-size - 1pt)

  set outline(depth: 2)
  set bibliography(style: "gost-r-7-0-5-2008-numeric-alphabetical.csl", title: "Список литературы")

  doc
}

#let normal(font-size: 12pt, doc) = {
  set page(
    paper: "a4",
    margin: 2cm,
  )

  set heading(numbering: "1.")


  set enum(full: true)
  set enum(numbering: formatter("{decimal}.{lower-russian}."))

  set par(
    leading: 1em,
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set text(font: "Times New Roman", size: font-size, lang: "ru")
  show raw: set text(font: "Menlo", lang: "en")

  set outline(depth: 2)
  set bibliography(style: "gost-r-7-0-5-2008-numeric-alphabetical.csl", title: "Список литературы")


  doc
}
