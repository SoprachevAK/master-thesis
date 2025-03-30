#import "@preview/numberingx:0.0.1": formatter

#let conf(
  doc,
) = {
  let font-size = 14pt

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

  // show heading.where(level: 4): it => [
  //   #set align(left)
  //   #box([et]) #h(1.25cm)
  // ]

  // show heading.where(level: 4): it => [
  //   #it.body
  // ]


  // show table: set text(size: 12pt)
  // show table.cell.where(y: 0): strong

  // show figure: it => [#it #h(1.25cm)]
  // show figure.where(kind: table): set figure.caption(position: top)

  doc
}


#let paragraph(title, doc) = {
  [#h(-1.25cm) #text(weight: "bold", title) #h(1em)]
  doc
}

#let fig(caption, path, label, width: 100%) = {
  figure(caption: caption)[
    #image(path, width: width)
  ]
}
