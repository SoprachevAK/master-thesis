#import "@preview/muchpdf:0.1.0": muchpdf

#let fig(caption, path, width: 100%) = {
  figure(caption: caption)[
    #if path.ends-with(".pdf") {
      muchpdf(read(path, encoding: none), width: width)
    } else {
      image(path, width: width)
    }
  ]
}
