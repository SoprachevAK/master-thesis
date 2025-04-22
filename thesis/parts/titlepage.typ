

#set text(font: "Times New Roman", size: 12pt, lang: "ru")

#set par(
  justify: true,
  linebreaks: "optimized",
  first-line-indent: 0em,
)

#{
  set par(leading: 0.4em)
  align(center)[
    #set text(size: 14pt, hyphenate: false)
    Министерство науки и высшего образования Российской Федерации\
    Санкт-Петербургский политехнический университет Петра Великого\
    Институт компьютерных наук и кибербезопасности\
    Высшая школа программной инженерии
    #v(1em)
  ]
}

#set par(leading: 0.8em)

#align(
  right,
  block[
    #set align(left)
    Работа допущена к защите\
    Директор ВШПИ
    #v(-0.5em)
    #align(right)[П. Д. Дробинцев]
    #v(-0.5em)
    #sym.quote.angle.l.double #h(1.5em) #sym.quote.angle.r.double #h(80pt) 2025 г.
  ],
)

#v(2em)

#align(center)[
  #text(weight: "black")[
    #upper[Выпускная квалификационная работа]\
    магистерская диссертация

    #v(1.5em)

    #upper[
      Разработка и архитектурные особенности PolyMap: платформа для проектирования и размещения интерактивных карт помещений и территорий. Применение Serverless-подхода.
    ]
  ]
]

#v(1.5em)


по направлению подготовки (специальности)\
*09.04.04 Программная инженерия*

Направленность (профиль)\
*09.04.04_01 Технология разработки и сопровождения качественного
программного продукта*

#v(3em)

#{
  set text(size: 12pt, hyphenate: false)
  set par(justify: false, leading: 0.5em)
  show grid.cell.where(x: 3): set align(center)

  grid(
    columns: (1fr, 130pt, 0pt, 110pt, 0pt),
    row-gutter: 2em,
    [Выполнил студент гр.\ 5140904/20102], [], [\/], [Сопрачев А. К.], [\/],
    [Руководитель доцент,\ к.т.н], [], [\/], [Дробинцев П. Д.], [\/],
    [Консультант по\ нормоконтролю], [], [\/], [Локшина Е . Г.], [\/],
  )
}

#v(1fr)

#align(center)[
  Санкт-Петербург\
  2025
]
