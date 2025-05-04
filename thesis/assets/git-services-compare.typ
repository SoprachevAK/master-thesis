#figure(caption: [Сравнение GitHub, GitLab и Bitbucket])[
  #show table.cell.where(x: 0): set text(weight: "bold")
  #show table.cell.where(y: 0): set text(weight: "bold")
  #table(
    columns: (auto, auto, auto, auto),
    align: (horizon + left, horizon, horizon, horizon),
    table.header([], [GitHub], [GitLab], [Bitbucket]),
    [*Модель хостинга*], [Только облачный], [Облачный + самостоятельный (открытый исходный код)], [Только облачный],
    [*Приватные репозитории*], [Да, бесплатно], [Да, бесплатно], [Да, бесплатно],
    [*CI/CD*],
    [Есть, GitHub Actions, большой Marketplace расширений],
    [GitLab CI/CD, можно подключать свои Runner, нет готовых плагинов],
    [Pipelines, Pipes от Atlassian (не так много)],

    [*Code Review*], [Pull Requests, есть AI проверка], [Merge Requests], [Pull Requests],
    [*Issue-трекинг*], [Встроенный], [Встроенный], [Встроенный],
    [*Интеграции*],
    [Широкая инфрастуктура, есть GitHub Projects для полноценного ведения проекта],
    [Есть аналог GitHub Projects (Issue Boards)],
    [Нет],

    [*Управление доступом*], [Роли], [Группы и уровни], [Гибкие права],
    [*Безопасность и проверка кода*], [Dependabot, секреты], [SAST/DAST, секреты], [Сканирование, секреты],
    [*Сообщество и популярность*],
    [Самый крупный],
    [Набирает популярность, в основном корпоративно],
    [Теряет популярность],
  )
]
