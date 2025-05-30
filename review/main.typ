
#set document(
  author: "Сечинский Егор Валерьевич",
  title: "Отзыв о ВКР",
  date: auto,
)

#set page(margin: 20mm)
#set par(leading: 0.5em, first-line-indent: 0pt)
#set text(size: 11pt, lang: "ru")
#set text(font: "Arial")

#show heading.where(level: 1): set text(size: 16pt, weight: "regular")
#show heading.where(level: 1): it => block(above: 2em, below: 0.75em)[#it]

#{
  set align(center)
  text(weight: 600, size: 16pt)[
    #upper[Рецензия]\
  ]

  [
    на выпускную квалификационную работу\
    *"Разработка и архитектурные особенности PolyMap: платформа для проектирования и размещения интерактивных карт помещений и территорий.\ Применение Serverless-подхода"*\
    выполненную обучающимся гр. 5140904/30102\
    Санкт-Петербургского политехнического университета Петра Великого\
    Сопрачевым Андреем Константиновичем
  ]

  v(1em)
}

#set par(justify: true)
#set text(hyphenate: true)

= Актуальность работы
Навигация в зданиях и кампусах до сих пор лишена массовых и доступных решений. Корпоративные платформы закрыты для стороннего контента, а стартап-сервисы уступают им по скорости и качеству. Автор предлагает модель «карта как сервис», объединяющую высокопроизводительный WebGL-рендеринг и SaaS-хостинг, что позволяет снизить конечную стоимость, сохраняя высокое качество реализации. Актуальность работы подтверждается статистикой использования пилотной iOS-версии PolyMap, которая показала высокую востребованность среди студентов университета.

= Характеристика работы
Работа включает несколько разделов, логично выстроенных от анализа рынка до результатов тестирования. Цели сформулированы чётко и соотнесены с задачами, каждая из которых привязана к конкретной главе.

Введение и обзор. Приведён обстоятельный сравнительный анализ существующих решений с примерами для каждой категории. Выделены сильные стороны, которые следует реализовать в PolyMap для достижения конкурентоспособности.

Архитектура. Выбран микросервисный подход, соответствующий современным практикам. Serverless-оркестрация обоснована экономически и технологически, отдельно подчеркнута реализация в отечественной инфраструктуре «Яндекс Облако».

Реализация. Подробно описан процесс отображения карты на WebGL, включая использование атласов, статическое запекание и меры энергосбережения на мобильных устройствах. Реализована система пружинных анимаций, повышающая отзывчивость пользовательского интерфейса.

CI/CD. Процесс развёртывания соответствует промышленным стандартам: тесты и статический анализ кода интегрированы в пайплайн GitHub Actions, для взаимодействия с облаком применяется подход IaC посредством Terraform. Раскрыты преимущества Serverless-подхода, позволяющего создавать изолированный стенд для каждого pull request.

= Достоинства работы
*1. Отечественная инфраструктура.* В качестве облачного провайдера, автор выбрал «Яндекс Облако», что обеспечивает соответствие требованиям безопасности и снижает инфраструктурные риски.\
*2. Гибкость архитектуры.* Архитектура спроектирована качественно, с учётом будущих расширений.\
*3. Практическая значимость.* Проект решает реальную задачу, востребованную в прикладной сфере.\
*4. Применение современных технологий.* В работе использованы актуальные инструменты и подходы: WebGL, Serverless, Terraform, Bun.\
*5. Применение СППР.* Выбор некоторых технологий производился не на основе личных предпочтений, а с применением систем поддержки принятия решений (СППР), что повышает объективность выбора.\
*6. Проработка энергоэффективности.* Внедрены механизмы снижения энергопотребления на мобильных устройствах, что является важным аспектом, однако крайне редко встречается в подобных проектах.

= Замечания по работе
*1. Недостаточная детализация микросервисов.* Не раскрыты интерфейсы, модели данных и показатели производительности; отсутствуют примеры работы отдельных микросервисов (например, генератора стилизованных QR-кодов).\
*2. Отсутствует раздел о внутреннем позиционировании.* Не рассмотрены технологии indoor-позиционирования (BLE-маяки, Wi-Fi RTT, UWB и др.). Несмотря на то, что в проекте не реализована эта функциональность, было бы полезно изучить существующие решения и возможности их интеграции в будущем.

= Заключение
Выпускная квалификационная работа Сопрачева А. К. представляет актуальное и технологически зрелое решение. Автор продемонстрировал глубокое понимание предметной области, умение проектировать масштабируемую архитектуру и применять современные инструменты. Несмотря на отмеченные замечания, работа выполнена на высоком уровне и рекомендуется к защите с оценкой «Отлично».

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
