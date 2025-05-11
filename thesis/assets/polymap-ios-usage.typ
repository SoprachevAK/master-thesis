#figure(caption: [Потребляемые ресурсы пилотной версии PolyMap iOS за сентябрь 2024])[
  #show table.cell.where(y: 0): set text(weight: "bold")

  #table(
    columns: (auto, auto),
    align: (x, y) => if y == 0 { center } else { left },
    // align: horizon,
    table.header([Ресурс], [Объём]),
    [Открытие карты], [`600 000`],
    [Пользователей], [`8 000`],
    [Просмотров информации об аннотации], [`70 000`],
    [Построено маршрутов], [`10 000`],
    [Открыто приглашений], [`250`]
  )
]<polymap-ios-usage>
