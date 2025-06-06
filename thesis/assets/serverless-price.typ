#figure(caption: [Стоимость используемых Serverless ресурсов в Yandex Cloud на 01.05.2025])[
  #show table.cell.where(y: 0): set text(weight: "bold")

  #table(
    columns: (auto, auto, auto, 1fr),
    align: horizon,
    table.header(table.cell(colspan: 2)[Ресурс], [Стоимость], [Бесплатно]),
    table.cell(colspan: 2)[API Gateway], [`120₽/1М` запросов], [Первые `100k` в месяц],
    table.cell(rowspan: 3, colspan: 2)[Serverless Containsers],
    [`16₽/1М` вызовов], [Первые `1М` вызовов в месяц],
    [`3.2₽/ГБ×час` ОЗУ], [Первые `1ГБ×час` в месяц],
    [`4.8₽/vCPU×час`], [Первые `1vCPU×час` в месяц],
    table.cell(colspan: 2)[Message Queue], [`48.76₽/1М` запросов], [Первые `100k` в месяц],
    table.cell(rowspan: 2, colspan: 2)[Yandex Data Base],
    [`21.38₽/1М` Request Units], [Первый `1М` в месяц],
    [`21.38₽/1ГБ×месяц`], [Первый `1ГБ` в месяц],
    table.cell(rowspan: 3, colspan: 1)[Object Storage\ (Standard)],
    [`GET`], [`0.39₽/10000`], [Первые `100k` в месяц],
    [`POST`], [`0.48₽/1000`], [Первые `10k` в месяц],
    [`DELETE`], table.cell(colspan: 2)[Бесплатно],
    table.cell(rowspan: 4, colspan: 1)[Исходящий\ трафик],
    [< `1ТБ`], [`1.53₽/1ГБ`], [Первые `100Гб` в месяц],
    [< `50ТБ`], table.cell(colspan: 2)[`1.28₽/1ГБ`],
    [< `100ТБ`], table.cell(colspan: 2)[`1.20₽/1ГБ`],
    [> `100ТБ`], table.cell(colspan: 2)[`1.15₽/1ГБ`],
  )
]<serverless-price>
