== Исходные данные

#figure(caption: [Исходные данные])[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (left, horizon, horizon, horizon, horizon, horizon),
    table.header([], [Вес], [Vue3], [React], [Angular], [Svelte]),
    [*↑ Производительность*], [2], [9], [8], [7], [10],
    [*↑ Размер бандла*], [0.7], [9], [8], [6], [10],
    [*↑ TypeScript*], [2], [9], [9], [10], [5],
    [*↑ Встроенные возможности*], [1], [10], [5], [8], [6],
    [*↑ Реактивность (model)*], [2], [10], [7], [6], [7],
    [*↑ Минимальные зависимости*], [0.5], [8], [7], [6], [10],
    [*↑ Стабильность API*], [1.5], [8], [10], [9], [6],
    [*↑ Инструменты разработки*], [1], [10], [10], [8], [7],
    [*↑ Документация, сообщество*], [1], [8], [10], [6], [4],
  )
]


=== Нормализованные веса

Для корректной работы алгоритма веса критериев были нормализованы.
- *Производительность* - 0.17
- *Размер бандла* - 0.06
- *TypeScript* - 0.17
- *Встроенные возможности* - 0.09
- *Реактивность (model)* - 0.17
- *Минимальные зависимости* - 0.04
- *Стабильность API* - 0.13
- *Инструменты разработки* - 0.09
- *Документация, сообщество* - 0.09
== Ход решения

Для определения оптимального варианта были построены матрицы бинарных отношений (БО),
после чего к ним были применены следующие механизмы:
- Механизмы доминирования
- Механизмы блокирования
- Турнирный механизм
- Механизм K-max
По каждому механизму был выбран лучший вариант, после чего была составлена сводная таблица с результатами

=== Механизм доминирования

Сколько раз варианты доминируют по всем БО. В матричном виде выбираются варианты, у которых в строках все значения равны 1.
- *Vue3* доминируют в категориях: *Встроенные возможности, Реактивность (model), Инструменты разработки* `=> 0.09 + 0.17 + 0.09 = `*`0.34`*
- *React* доминируют в категориях: *Стабильность API, Инструменты разработки, Документация, сообщество* `=> 0.13 + 0.09 + 0.09 = `*`0.3`*
- *Angular* доминируют в категориях: *TypeScript* `=> `*`0.17`*
- *Svelte* доминируют в категориях: *Производительность, Размер бандла, Минимальные зависимости* `=> 0.17 + 0.06 + 0.04 = `*`0.27`*
#figure(caption: [Сводная таблица результатов механизма доминирования])[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto),
    align: (left, horizon, horizon),
    table.header([Вариант], [Баллы], [Место]),
    [*Vue3*], [0.34], [1],
    [*React*], [0.3], [2],
    [*Angular*], [0.17], [4],
    [*Svelte*], [0.27], [3],
  )
]


=== Механизм блокирования

Сколько раз варианты блокируют по всем БО. В матричном виде выбираются варианты, у которых в столбцах все значения равны 1.
- *Vue3* блокируют в категориях: *Встроенные возможности, Реактивность (model)* `=> 0.09 + 0.17 = `*`0.26`*
- *React* блокируют в категориях: *Стабильность API, Документация, сообщество* `=> 0.13 + 0.09 = `*`0.21`*
- *Angular* блокируют в категориях: *TypeScript* `=> `*`0.17`*
- *Svelte* блокируют в категориях: *Производительность, Размер бандла, Минимальные зависимости* `=> 0.17 + 0.06 + 0.04 = `*`0.27`*
#figure(caption: [Сводная таблица результатов механизма блокирования])[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto),
    align: (left, horizon, horizon),
    table.header([Вариант], [Баллы], [Место]),
    [*Vue3*], [0.26], [2],
    [*React*], [0.21], [3],
    [*Angular*], [0.17], [4],
    [*Svelte*], [0.27], [1],
  )
]


=== Турнирный механизм

Сколько раз варианты предпочтительнее
- *Vue3* - в категории:
  - *Производительность* – опережает *React, Angular* `=> 0.17 + 0.17 = `*`0.34`*
  - *Размер бандла* – опережает *React, Angular* `=> 0.06 + 0.06 = `*`0.12`*
  - *TypeScript* – опережает *Svelte* `=> `*`0.17`*\ Симметрично c *React* `=> 0.17 / 2 = `*`0.09`*
  - *Встроенные возможности* – опережает *React, Angular, Svelte* `=> 0.09 + 0.09 + 0.09 = `*`0.26`*
  - *Реактивность (model)* – опережает *React, Angular, Svelte* `=> 0.17 + 0.17 + 0.17 = `*`0.51`*
  - *Минимальные зависимости* – опережает *React, Angular* `=> 0.04 + 0.04 = `*`0.09`*
  - *Стабильность API* – опережает *Svelte* `=> `*`0.13`*
  - *Инструменты разработки* – опережает *Angular, Svelte* `=> 0.09 + 0.09 = `*`0.17`*\ Симметрично c *React* `=> 0.09 / 2 = `*`0.04`*
  - *Документация, сообщество* – опережает *Angular, Svelte* `=> 0.09 + 0.09 = `*`0.17`*
- *React* - в категории:
  - *Производительность* – опережает *Angular* `=> `*`0.17`*
  - *Размер бандла* – опережает *Angular* `=> `*`0.06`*
  - *TypeScript* – опережает *Svelte* `=> `*`0.17`*\ Симметрично c *Vue3* `=> 0.17 / 2 = `*`0.09`*
  - *Реактивность (model)* – опережает *Angular* `=> `*`0.17`*\ Симметрично c *Svelte* `=> 0.17 / 2 = `*`0.09`*
  - *Минимальные зависимости* – опережает *Angular* `=> `*`0.04`*
  - *Стабильность API* – опережает *Vue3, Angular, Svelte* `=> 0.13 + 0.13 + 0.13 = `*`0.38`*
  - *Инструменты разработки* – опережает *Angular, Svelte* `=> 0.09 + 0.09 = `*`0.17`*\ Симметрично c *Vue3* `=> 0.09 / 2 = `*`0.04`*
  - *Документация, сообщество* – опережает *Vue3, Angular, Svelte* `=> 0.09 + 0.09 + 0.09 = `*`0.26`*
- *Angular* - в категории:
  - *TypeScript* – опережает *Vue3, React, Svelte* `=> 0.17 + 0.17 + 0.17 = `*`0.51`*
  - *Встроенные возможности* – опережает *React, Svelte* `=> 0.09 + 0.09 = `*`0.17`*
  - *Стабильность API* – опережает *Vue3, Svelte* `=> 0.13 + 0.13 = `*`0.26`*
  - *Инструменты разработки* – опережает *Svelte* `=> `*`0.09`*
  - *Документация, сообщество* – опережает *Svelte* `=> `*`0.09`*
- *Svelte* - в категории:
  - *Производительность* – опережает *Vue3, React, Angular* `=> 0.17 + 0.17 + 0.17 = `*`0.51`*
  - *Размер бандла* – опережает *Vue3, React, Angular* `=> 0.06 + 0.06 + 0.06 = `*`0.18`*
  - *Встроенные возможности* – опережает *React* `=> `*`0.09`*
  - *Реактивность (model)* – опережает *Angular* `=> `*`0.17`*\ Симметрично c *React* `=> 0.17 / 2 = `*`0.09`*
  - *Минимальные зависимости* – опережает *Vue3, React, Angular* `=> 0.04 + 0.04 + 0.04 = `*`0.13`*
#figure(caption: [Сводная таблица результатов турнирного механизма])[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto),
    align: (left, horizon, horizon),
    table.header([Вариант], [Баллы], [Место]),
    [*Vue3*], [2.09], [1],
    [*React*], [1.64], [2],
    [*Angular*], [1.11], [4],
    [*Svelte*], [1.16], [3],
  )
]


=== Механизм K-max

#figure(caption: [Таблица результатов механизма K-max для категории Производительность])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [2], [2], [2], [2], [8 \* 0.17 = 1.37], [-],
    [*React*], [1], [1], [1], [1], [4 \* 0.17 = 0.68], [-],
    [*Angular*], [0], [0], [0], [0], [0], [-],
    [*Svelte*], [3], [3], [3], [3], [12 \* 0.17 = 2.05], [2.05 (Строго наиб.)],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Размер бандла])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [2], [2], [2], [2], [8 \* 0.06 = 0.48], [-],
    [*React*], [1], [1], [1], [1], [4 \* 0.06 = 0.24], [-],
    [*Angular*], [0], [0], [0], [0], [0], [-],
    [*Svelte*], [3], [3], [3], [3], [12 \* 0.06 = 0.72], [0.72 (Строго наиб.)],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории TypeScript])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [2], [1], [2], [1], [6 \* 0.17 = 1.03], [-],
    [*React*], [2], [1], [2], [1], [6 \* 0.17 = 1.03], [-],
    [*Angular*], [3], [3], [3], [3], [12 \* 0.17 = 2.05], [2.05 (Строго наиб.)],
    [*Svelte*], [0], [0], [0], [0], [0], [-],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Встроенные возможности])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [3], [3], [3], [3], [12 \* 0.09 = 1.03], [1.03 (Строго наиб.)],
    [*React*], [0], [0], [0], [0], [0], [-],
    [*Angular*], [2], [2], [2], [2], [8 \* 0.09 = 0.68], [-],
    [*Svelte*], [1], [1], [1], [1], [4 \* 0.09 = 0.34], [-],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Реактивность (model)])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [3], [3], [3], [3], [12 \* 0.17 = 2.05], [2.05 (Строго наиб.)],
    [*React*], [2], [1], [2], [1], [6 \* 0.17 = 1.03], [-],
    [*Angular*], [0], [0], [0], [0], [0], [-],
    [*Svelte*], [2], [1], [2], [1], [6 \* 0.17 = 1.03], [-],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Минимальные зависимости])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [2], [2], [2], [2], [8 \* 0.04 = 0.34], [-],
    [*React*], [1], [1], [1], [1], [4 \* 0.04 = 0.17], [-],
    [*Angular*], [0], [0], [0], [0], [0], [-],
    [*Svelte*], [3], [3], [3], [3], [12 \* 0.04 = 0.51], [0.51 (Строго наиб.)],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Стабильность API])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [1], [1], [1], [1], [4 \* 0.13 = 0.51], [-],
    [*React*], [3], [3], [3], [3], [12 \* 0.13 = 1.54], [1.54 (Строго наиб.)],
    [*Angular*], [2], [2], [2], [2], [8 \* 0.13 = 1.03], [-],
    [*Svelte*], [0], [0], [0], [0], [0], [-],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Инструменты разработки])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [3], [2], [3], [2], [10 \* 0.09 = 0.85], [-],
    [*React*], [3], [2], [3], [2], [10 \* 0.09 = 0.85], [-],
    [*Angular*], [1], [1], [1], [1], [4 \* 0.09 = 0.34], [-],
    [*Svelte*], [0], [0], [0], [0], [0], [-],
  )
]


#figure(caption: [Таблица результатов механизма K-max для категории Документация, сообщество])[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([], [HRo+\ ER+\ NR], [HRo+\ NR], [HRo+\ ER], [HRo], [Sjp], [Sjm]),
    [*Vue3*], [2], [2], [2], [2], [8 \* 0.09 = 0.68], [-],
    [*React*], [3], [3], [3], [3], [12 \* 0.09 = 1.03], [1.03 (Строго наиб.)],
    [*Angular*], [1], [1], [1], [1], [4 \* 0.09 = 0.34], [-],
    [*Svelte*], [0], [0], [0], [0], [0], [-],
  )
]


#figure(caption: [Сводная таблица результатов механизма K-max])[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: horizon,
    table.header([Вариант], [Сумма sJp], [Место sJp], [Сумма sJm], [Место sJm]),
    [*Vue3*], [8.34], [1], [3.08], [2],
    [*React*], [6.56], [2], [2.56], [3],
    [*Angular*], [4.44], [4], [2.05], [4],
    [*Svelte*], [4.65], [3], [3.28], [1],
  )
]


== Результат

По результатам всех механизмов, в зависимости от полученного места были начислены баллы каждому варианту

#figure(caption: [Итоговая таблица результатов])[
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    align: horizon,
    table.header([Вариант], [Дом], [Блок], [Тур], [Sjp], [Sjm], [ИТОГО], [Место]),
    [*Vue3*], [4], [3], [4], [4], [3], [18], [1],
    [*React*], [3], [2], [3], [3], [2], [13], [3],
    [*Angular*], [1], [1], [1], [1], [1], [5], [4],
    [*Svelte*], [2], [4], [2], [2], [4], [14], [2],
  )
]


=== Итоговый вариант

Максимальную сумму баллов набрал вариант *Vue3* с суммой *18* баллов

