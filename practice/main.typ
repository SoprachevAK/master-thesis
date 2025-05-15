
#import "./utils/setup.typ": *

#set document(
  author: "Сопрачев Андрей Константинович",
  title: "Отчет о прохождении производственой практики",
  date: auto,
)

#show: normal.with(font-size: 12pt)
#show: final.with(font-size: 14pt)


#include "./title/plan.typ"
#pagebreak()

#include "./title/report.typ"
#pagebreak()


#outline(depth: 3, indent: 1em)
#set page(numbering: "1")

#{
  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(numbering: "Глава 1.")
  include "../thesis/parts/3-main-part.typ"
}


#pagebreak()
#bibliography("../thesis/biblio.bib")

#show: annexes
#include "../thesis/parts/appendix/appendix.typ"
