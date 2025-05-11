#figure(caption: [Сравнение производительности Bun Node и Deno])[
  #show table.cell.where(y: 0): set text(weight: "bold")

  #table(
    columns: (auto, auto, auto, auto),
    align: horizon,
    table.header([Тест], [Bun], [Deno], [Node]),
    [Express.js `'hello world'`, rps], [59 026], [25 335], [19 039],
    [PostgreSQL 100 rows x 100 parallel queries, qps], [50 251], [11 821], [14 398],
    [WebSocket, messages sent per second], [2 536 227], [1 320 525], [435 099],
  )
]<bun-vs-node-vs-deno>
