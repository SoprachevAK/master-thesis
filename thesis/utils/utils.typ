#import "@preview/muchpdf:0.1.0": muchpdf
#import "@preview/subpar:0.2.2"
#import "@preview/numberingx:0.0.1": formatter

#let fig(caption, path, width: 100%) = {
  figure(caption: caption)[
    #if path.ends-with(".pdf") {
      muchpdf(read(path, encoding: none), width: width)
    } else {
      image(path, width: width)
    }
  ]
}

#let subfig = subpar.grid.with(
  numbering-sub: (sup, sub) => formatter("({lower-russian})")(sub),
  numbering-sub-ref: formatter("{decimal}.{lower-russian}"),
)

#let todo(doc) = {
  block(
    fill: rgb("#ffdec9"),
    inset: 8pt,
    radius: 4pt,
    width: 100%,
    [
      #text(weight: "extrabold")[TODO:] #doc
    ],
  )
}
