#import "@preview/numberingx:0.0.1": formatter


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
  show: shared

  set page(
    paper: "a4",
    margin: 2cm,
  )

  set heading(numbering: "1.")


  set enum(full: true)
  set enum(numbering: formatter("{decimal}.{lower-russian}."))

  set par(
    leading: 0.6em,
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set text(font: "Times New Roman", size: font-size, lang: "ru")
  show raw: set text(font: "Menlo", lang: "en")

  set table(stroke: 0.5pt + rgb("#2c2c2c"))

  set outline(depth: 2)
  set bibliography(style: "gost-r-7-0-5-2008-numeric-alphabetical.csl", title: "Список литературы")


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

    pagebreak(weak: true)
    it
  }

  state("appendix").update(true)
  counter(heading).update(0)
  content
}
