

#set text(font: "Times New Roman", size: 14pt, lang: "ru", hyphenate: false)

#set par(
  justify: false,
  linebreaks: "optimized",
  first-line-indent: 0em,
)

#{
  set par(leading: 0.4em)
  align(center)[
    Министерство науки и высшего образования Российской Федерации\
    Санкт-Петербургский политехнический университет Петра Великого\
    Высшая школа программной инженерии
  ]
}

#set par(leading: 0.4em)
#v(0.8em)

#grid(
  columns: (1fr, 1fr),
  [],
  [
    Работа допущена к защите\
    Директор ВШПИ
    #v(-0.5em)
    #stack(dir: ltr, spacing: 0.3em, align(bottom)[#line(length: 5.5em, stroke: 0.5pt)], [П.Д.Дробинцев])
    #v(-0.5em)
    #sym.quote.angle.l.double
    #box[#line(length: 2em, stroke: 0.5pt)]
    #sym.quote.angle.r.double
    #h(0.2em)
    #box[#line(length: 6em, stroke: 0.5pt)] 2025 г.
  ],
)


#v(2em)

#align(center)[
  #text(weight: "black")[
    #upper[Выпускная квалификационная работа]

    магистерская диссертация

    #v(1em)

    #upper[
      Разработка и архитектурные особенности PolyMap: платформа для проектирования и размещения интерактивных карт помещений и территорий. Применение Serverless-подхода.
    ]
  ]
]

#v(1em)


по направлению подготовки (специальности)\
*09.04.04 Программная инженерия*

Направленность (профиль)\
*09.04.04_01 Технология разработки и сопровождения качественного
программного продукта*

#v(3em)

#{
  set text(size: 12pt, hyphenate: false)
  set par(justify: false, leading: 0.5em)

  grid(
    columns: (1fr, 130pt, 110pt),
    row-gutter: 2em,
    [Выполнил студент гр.\ 5140904/30102], [], [ А.К.Сопрачев],
    [Руководитель доцент,\ кандидат технических наук], [], [ П.Д.Дробинцев],
    [Консультант по\ нормоконтролю], [], [ Е.Г.Локшина],
  )
}

#v(1fr)

#align(center)[
  Санкт-Петербург\
  2025
]
