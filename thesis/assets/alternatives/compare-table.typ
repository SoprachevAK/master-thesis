#figure(caption: [Сравнение таблица существующих решений])[
  #show table.cell.where(y: 0): set text(weight: "bold")

  #table(
    columns: (auto, auto, auto, auto),
    align: horizon,
    table.header([Тест], [Bun], [Deno], [Node]),
  )
]
