
#import "./utils/setup.typ": conf

#show: conf
#set document(
  author: "Сопрачев Андрей Константинович",
  title: "Отчет о прохождении научно-исследовательской работы",
  date: auto,
)

#include "./title/plan.typ"
#pagebreak()
#include "./title/report.typ"
#pagebreak()


#set page(margin: 20mm)

#outline()
#show heading.where(level: 1): set heading(numbering: "1.")
#set page(numbering: "1")
#include "./parts/page1.typ"

#pagebreak()
#show heading.where(level: 1): set heading(numbering: none)
#bibliography("./parts/biblio.bib")
