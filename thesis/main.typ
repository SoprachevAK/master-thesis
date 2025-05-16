#import "utils/setup.typ": *

#set document(
  author: "Сопрачев Андрей Константинович",
  title: "Выпускная квалификационная работа. Разработка и архитектурные особенности PolyMap: платформа для проектирования и размещения интерактивных карт помещений и территорий. Применение Serverless-подхода.",
  date: auto,
)

#show: normal.with(font-size: 12pt)
#show: final.with(font-size: 14pt)



#include "parts/titlepage.typ"
#pagebreak()

#include "parts/task.typ"
#pagebreak()


#{
  set heading(numbering: none, outlined: false)
  include "parts/1-abstract-ru.typ"
  pagebreak()
  include "parts/1-abstract-en.typ"
  pagebreak()
}


#set page(numbering: "1")

#outline(depth: 3, indent: 1em)
#pagebreak()

#{
  set heading(numbering: none, outlined: false)
  show heading.where(level: 1): set heading(outlined: true)
  include "parts/2-introduction.typ"
}

#{
  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(numbering: "Глава 1.")
  include "parts/3-main-part.typ"
}

#{
  set heading(numbering: none, outlined: false)
  show heading.where(level: 1): set heading(outlined: true)
  include "parts/4-conclusion.typ"
}

#pagebreak()
#bibliography("biblio.bib")

#show: annexes
#include "parts/appendix/appendix.typ"
