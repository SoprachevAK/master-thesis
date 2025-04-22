
#let fig(caption, path, label, width: 100%) = {
  figure(caption: caption)[
    #image(path, width: width)
  ]
}
