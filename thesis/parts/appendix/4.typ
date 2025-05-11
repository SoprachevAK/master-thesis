#import "../../utils/utils.typ": listing
= Тестирование времени ответа в Serverless режиме<serverless-cold-start-framework>

- Тесты проводились в Yandex Cloud
- Использовался Serverless Containers
- Запросы отправлялись напрямую в Serverless Containers по служебному URL
- Время ответа измерялось с помощью Yandex Cloud Logging -- учитывается чистое время на запрос отображаемое в логах, без квантизации
- Проводилось по три теста:
  - $"Cold"_n$ -- время ответа при $n$ холодном запуске. После прошлого запроса пауза 2 минуты
  - $"Hot"_n$ -- время ответа при $n$ горячем запуске. После прошлого запроса пауза не более 10 секунд
- По трём запускам берётся среднее значение


#{
  let results = csv("../../assets/serverless-cold-start-framework-data.csv")
  show figure.where(kind: table): set block(breakable: true)

  figure(caption: [Сравнительная таблица времени ответа разных стеков в Serverless режиме])[
    #show table.cell.where(y: 0): set text(weight: "bold")
    #show table.cell.where(x: 0): set par(justify: false)

    #table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
      align: (left, horizon, horizon, horizon, horizon, horizon, horizon, horizon, horizon),
      table.header(
        [Технология],
        [$"Cold"_1$],
        [$"Cold"_2$],
        [$"Cold"_3$],
        [$"Hot"_1$],
        [$"Hot"_2$],
        [$"Hot"_3$],
        [$"Cold"_"avg"$],
        [$"Hot"_"avg"$],
      ),
      ..results.flatten()
    )
  ]
}
