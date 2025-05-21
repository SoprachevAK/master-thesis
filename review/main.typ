
#set document(
  author: "Сечинский Егор Валерьевич",
  title: "Отзыв о ВКР",
  date: auto,
)

#set page(margin: 20mm)
#set par(leading: 0.5em, first-line-indent: 0pt)
#set text(size: 12pt, lang: "ru")

#show heading.where(level: 1): set text(size: 14pt)

#{
  set align(center)
  text(weight: "black", size: 16pt)[
    #upper[Рецензия]
  ]

  v(0em)

  [
    на выпускную квалификационную работу\
    *"Разработка и архитектурные особенности PolyMap: платформа для проектирования и размещения интерактивных карт помещений и территорий.\ Применение Serverless-подхода"*\
    выполненную обучающимся гр.5140904/30102\
    Санкт-Петербургского политехнического университета Петра Великого\
    *Сопрачевым Андреем Константиновичем*
  ]

  v(1em)
}


= Актуальность работы
= Характеристика работы
= Замечания по работе
= Заключение


#v(4em)
#{
  set text(size: 12pt, hyphenate: false)
  set par(justify: false)
  show grid.cell.where(x: 3): set align(center)

  grid(
    columns: (1fr, 130pt, 0pt, 110pt, 0pt),
    row-gutter: 3em,
    align: bottom,
    [Рецензент\ Генеральный директор ООО "Нинсар"], [], [\/], [Сечинский Е. В.], [\/],
  )
}
