# Введение и постановка задачи

## Общая идея и проблема

* Навигация внутри кампусов, зданий и частных территорий остаётся неудобной: готовые решения дорогие или слабее городских карт.
* **PolyMap** предлагается как *«карта-как-сервис»* — конструктор + хостинг интерактивных 2D/3D-карт; цель — совместить высокое качество и доступность.

## Актуальность

* Продолжение бакалаврской ВКР 2022 («PolyMap iOS»).
* Пилотная iOS-версия опубликована в App Store: ≥ 12 000 установок за 3 года.
* 6 525 уникальных активных пользователей за учебный 2023 г. (50 % всех студентов СПбПУ, оценка по доле iOS-устройств).
* 169 000 просмотров аннотаций за тот же период; пики — сентябрь и февраль.
* Данные подтверждают востребованность и целевые установки (начало семестров).

## Ограничения пилота

1. Только iOS.
2. Одна жёстко «зашитая» карта СПбПУ.
3. Требуется установка приложения → неудобно гостям/разовым посетителям.

## Цель магистерской работы

Создать **универсальную SaaS-платформу** для проектирования и публикации интерактивных карт:

* кроссплатформенная, браузерная;
* динамическая загрузка любых карт с сервера;
* масштабируемая Serverless-backend с быстрым откликом глобально.

## Задачи

* Сравнительный анализ существующих веб-решений карт.
* Проектирование гибкой клиент-серверной архитектуры.
* Разработка веб-клиента (mobile + desktop) для формата Extended-IMDF:

  * адаптивный UI, жесты мультитач.
* Реализация backend: хранение карт, шорт-линки, генерация QR, «поделиться».
* Настройка CI/CD, автотестов и анализа кода.

## Структура работы

1. **Обзор** существующих картографических решений.
2. **Архитектура** PolyMap (акцент — Serverless-подход).
3. **Реализация**: выбор стека (TS, Vue3, Three.js, Bun.js + Hono, Yandex Cloud Serverless, DynamoDB/S3, Cloudflare CDN).
4. **Тестирование и CI/CD**: процессы, преимущества Serverless для тестов.



# Анализ предметной области

* **Проблема — навигация внутри зданий и на прилегающих территориях.**
  Выделены два метода решения:

  1. **Аналоговый** — указатели, печатные схемы, продуманная планировка.
  2. **Цифровой** — мобильные/веб-карты, интерактивные стенды.
     Цифровой сегмент делится на продукты **крупных корпораций** и **стартапов** (PolyMap относится к последним).

## Аналоговый подход

* Эффективность зависит от архитектурной планировки (прямоугольная, Т-, Н-образная) и ясной нумерации кабинетов.
  Примеры:

  * **ГУК СПбПУ** — удачная H-форма коридоров.
  * **НИК СПбПУ** — сложная, запутанная структура.
* **Цветовое кодирование** помещений/этажей повышает читаемость; идея применима и в цифровых картах.

## Цифровой подход корпораций

| Сервис           | Сильные стороны                                                  | Ограничения / недостатки                                                                                                             |
| ---------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Apple Maps**   | Лучшая тех. детализация, 3D-и 2D-индор-карты                     | iOS/macOS only; нельзя добавлять свои карты; нет индор-маршрутов; веб-версия — бета без indoor                                       |
| **Google Maps**  | Реальная ширина дорог, 3D, индор 2D, доступен на всех платформах | Перспективные искажения в «2D»; закрытая база планировок; нет индор-маршрутов; слабая пешеходная детализация                         |
| **Яндекс Карты** | Высокая детализация РФ, 3D, индор 2D                             | Аналогичные искажения; свои карты недоступны; индор-маршруты не работают; обещанное новое поколение карт (анонс 12/2022) не выпущено |

**Общий вывод:** качество карт высокое, но для стороннего заказчика невозможно разместить собственные планы.

## Цифровой подход стартапов

| Сервис        | Плюсы                                                                        | Минусы                                                                                                                               |
| ------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **MazeMap**   | SaaS, реальные примеры, несколько зданий, сквозные маршруты                  | Устаревший дизайн, нет веб-версии (мобильные SDK), слой поверх MapBox, нет 3D, непрозрачные цены                                     |
| **Mappedin**  | Бесплатный web-конструктор, прозрачные цены, частичный 3D, AI-генерация карт | Конструктор нестабилен, мало примитивов, устаревший UI, ограниченное мультиздание                                                    |
| **Concept3D** | Художественный стиль, web, indoor + outdoor маршруты, своя территория        | Карты — статичные 2D-иллюстрации под видом 3D, низкая производительность, нет конструктора, непонятные цены, слабая мобильная версия |

**Общий вывод:** гибкие в размещении пользовательских карт, но часто уступают корпорациям по дизайну, производительности и функционалу.

## Сводная оценка

* **Корпорации:** высокое качество, но закрытая экосистема.
* **Стартапы:** открытость к кастомным планам, но технические и дизайнерские компромиссы.
* **PolyMap** заявляет цель объединить надёжность и качество с гибкостью размещения карт.

*(Во включённой в диплом сравнительной таблице эти особенности сведены в формальном виде.)*

# Архитектура. Serverless подход

## 1. Исходные требования и общая постановка задачи

* Требования формулировались через пользовательские сценарии для трёх ролей: **Заказчик**, **Пользователь**, **Художник**.
* Высокоуровневые компоненты: клиентская часть (просмотр карт), конструктор карт, серверная часть.
* Должна поддерживаться веб-кроссплатформа с перспективой нативных iOS/Android, масштабируемый публичный конструктор и размещение серверов в РФ.

## 2. Клиентская часть

* Реализуется как адаптивное веб-SPA на Extended-IMDF (просмотр, поиск, маршруты, расшаривание URL/QR).
* Поддерживает масштабирование карты, этажность, аннотации и маршруты с бесшовным переходом.

## 3. Конструктор карт

* Сейчас — настольное Unity-приложение; в будущем — публичная веб-версия с автоматическим пайплайном, синхронным редактированием и масштабируемой серверной обработкой.

## 4. Серверная часть и выбор архитектурного стиля

* Предполагаются резкие пики нагрузки (начало учебных дней/семестров, массовые мероприятия).
* Выбран **микросервисный Serverless**-подход вместо Kubernetes из-за простоты, pay-as-you-go и минимизации DevOps-издержек.
* Сравнение затрат: \~ 1600 ₽/мес Serverless vs ≈ 33 000 ₽/мес минимальный Kubernetes-кластер.

## 5. Serverless: плюсы/минусы

**Преимущества:** простота, меньше ошибок, оплата за фактическое потребление.
**Недостатки:** жёсткие требования к stateless-сервисам и очередям, vendor lock-in, ограничение по cold-start, не все БД в serverless-режиме.

## 6. Выбор облака

* Через СППР сравнили 7 провайдеров; лучшим из доступных в РФ признан **Yandex Cloud** (Serverless Containers, YDB, API Gateway, Message Queue, Object Storage и др.).

## 7. Ключевые сервисы Yandex Cloud

Cloud Functions (не используются), Serverless Container, API Gateway, Message Queue, YDB, Object Storage, CDN, Monitoring, Logging.

## 8. CDN и жизненный цикл запроса

* Статичные файлы карт отдаются через CDN; большинство трафика гасится на edge-узлах.
* Подробно описан путь запроса: DNS → CDN → API Gateway → Serverless Container → обратный путь + кеширование.

## 9. Детализированная микросервисная схема

* **Основные сервисы:** map-storage, web-map-back, share-back, qr-generator, og-generator, analytics, blob-storage, constructor-back, constructor-WS, dashboard-back.
* Приведены назначение, взаимодействия, обоснование отдельного выделения каждого микросервиса.

## 10. SEO-поддержка

* Для лендинга используется SSG.
* Для SPA-карт реализован web-map-back: динамич. генерация meta-tag’ов, sitemap.xml, robots.txt; SSR заменён SSG-мета-тегов ради производительности.

## 11. Экономика

* Подробная калькуляция стоимости компонентов Serverless (запросы, контейнеры, трафик); бесплатные квоты покрывают dev/test-среды.
* При аналогичной нагрузке Kubernetes дороже > 20 раз и требует отдельных тестовых кластеров.

## 12. Вывод главы

* Выбран **Serverless-подход** с Yandex Cloud → низкие расходы, высокая эластичность и чистая, слабо-связанная архитектура.
* Определён полный набор клиентов, микросервисов и вспомогательных инструментов; заложены требования на будущее (масштабирование, мобильные приложения, SEO).

# Реализация

## 1. Система контроля версий

* Выбран **полирепозиторий** для независимого цикла жизни микросервисов; совместимость обеспечивается строгим соблюдением backward-compatibility.
* Используется **GitHub (cloud)**: популярность, Marketplace-плагины и глубокая интеграция Copilot перевесили self-hosted-опцию GitLab.
* Создана отдельная GitHub-организация, где хранятся все сервисы PolyMap.

## 2. Клиентская часть (веб-карта)

### 2.1 Выбор фреймворка

* Рассмотрены React, Vue 3, Svelte, Angular.
* По многофакторной СППР Vue 3 занял 1-е место (18 баллов): реактивность Composition API, избирательные перерисовки, умеренный размер бандла, хорошая TypeScript-поддержка.

### 2.2 Рендеринг карты

* Отказ от Mapbox GL/Leaflet — реализован **собственный WebGL-движок** на **Three.js** с ортографической проекцией (готов к переходу на 3D).
* **Batching по типам полигонов**: число draw-calls снижено с \~3000 до **10-15**, frame-time ≈ **1.29 мс** (≈ 770 FPS запас при целевых 60).

### 2.3 Аннотации

* UI — Canvas API (HTML-DOM слишком тяжёл).
* Три типа (Occupant, Amenity, Attraction) ⟶ общий базовый класс, состояния («dot», «icon», «label», «pin», «selected»).
* **Текстурные атласы** для кэширования: ускоряют массовую отрисовку, тяжёлый текст рендерится один раз.

### 2.4 Анимации

* Tween-движок с **пружинной интерполяцией (spring)**; умеет прерывать и перекрывать анимации, повышая отзывчивость.

### 2.5 Поиск маршрутов

* Граф маршрутов + алгоритм **Дейкстры** (A\* не подошёл для неравномерных графов).
* Двухэтапный поиск «улица → вход» / «вход → цель», расчёт времени учитывает типы сегментов и переходы.

### 2.6 Энергоэффективность

* **Динамическая частота кадра**: 60 FPS только при взаимодействии, иначе рендер пауза; снижает GPU-активность 2-3×.

### 2.7 Хостинг фронта

* Статика в **Yandex Object Storage (S3-mode)** + Cloudflare CDN; длинный `Cache-Control`, быстрая инвалидация при деплое.

## 3. Серверная часть

### 3.1 Технологический стек

* **TypeScript + Bun + Hono**, собранный Bun-bundler; Distroless-образ (≈ 9 МБ).
* Преимущества Bun: JSC-движок, Zig-оптимизации, all-in-one tool, минимальный cold-start для Serverless Containers.

### 3.2 Шаблон микросервиса

* Репо-template: Bun-проект, Hono-echo, Dockerfile, GitHub Actions, Terraform (Container Registry → Serverless Container → API Gateway), ESLint, `bun test`, Cypress E2E.
* CI/CD разворачивает тестовый стенд после первого коммита.

### 3.3 Раздача карт

* Файлы карт через Cloudflare CDN; редкие обновления решаются **точечной purge-запросом** к API вместо сокращения TTL.

## 4. Мониторинг и логирование

* **Yandex Cloud Logging**: структурированные JSON-логи, фильтры, экспорт в S3.
* **Yandex Monitoring**: авто-метрики, кастомные дашборды, бесплатный тариф; алертинг (Email/Telegram/SMS).

## 5. Итоговые возможности готового веб-приложения

* Просмотр 2D-геометрии, аннотаций, поиск и построение маршрутов «улица ↦ кабинет».
* Полная адаптация под мобильные устройства (жесты, плавающая панель).


# Тестирование и оценка качества кода

* **Главная цель главы** — показать, как в PolyMap организованы контроль качества кода и тестирование на всех этапах жизненного цикла, и как это встроено в полностью автоматический CI/CD-процесс.
* **CI/CD**

  * Используются GitHub Actions (Ubuntu 22.04 runners).
  * Все микросервисы имеют набор workflow:

    * *PR-pipeline* — линтер, unit-tests, расчёт Terraform-плана, развёртывание изолированного serverless-стенда в Yandex Cloud, запуск E2E/visual-тестов, публикация отчёта и ссылки в PR.
    * *Merge-pipeline* — повторный линт+unit, деплой на `dev` или `main`, E2E на боевом/стейдж-стенде.
    * *PR close* — освобождение временной директории.
* **Infrastructure as Code**

  * Terraform (HCL) описывает контейнеры, реестр, API Gateway и др.
  * IAC хранится вместе с кодом — быстрая миграция и откат.
* **Serverless-особенности**

  * Yandex Cloud «директории» дают полную изоляцию окружений.
  * Проблема 5-минутного создания директорий решена авторским GitHub Action `yandex-cloud-worker-folder-manager` (worker-pool + теги), что резко ускорило CI.
  * Тестовые стенды бесплатны (укладываются в квоты).
* **Оценка качества кода**

  * Метрики: читаемость, поддерживаемость, тестируемость, производительность, надёжность, безопасность.
  * Инструменты:

    * ESLint (`@typescript-eslint`, `import`, `prettier`), запуск в CI blocking mode.
    * TypeScript `strict`.
    * `zod`-валидация входных данных (middleware Hono).
    * Раздельные сервисные аккаунты — минимальные IAM-права.
* **Модульные тесты**

  * `bun:test` (совместим с Jest, быстрее, поддержка mock/snapshot).
  * Код пишется с DI и интерфейсами для облегчения мокирования.
* **UI / E2E / интеграционное тестирование**

  * Рассмотрено Selenium ↔ Cypress ↔ Playwright; выбран **Cypress** (стабильность, component-тесты Vue, visual-diff через `image-snapshot`).
  * Cypress запускается в PR-pipeline, пишет видео проблемных тестов; используется и для проверки стилизованного QR-кода.
  * Интеграционное и E2E покрытие происходит на реальной serverless-инфраструктуре, что исключает необходимость in-memory mock БД и прочего; единственные моки — вызовы к другим микросервисам.
  * Отдельный репозиторий с суточными прод-smoke-тестами создаёт issue при сбоях.
* **Нагрузочное тестирование**

  * Не критично из-за «бесконечного» масштабирования, но использовано для проверки метрик и алертов.
* **Итоги главы** — обоснован выбор инструментов, показано, как ESLint, Bun test и Cypress интегрированы в CI/CD; благодаря Terraform и Serverless-архитектуре вся инфраструктурная и функциональная проверка автоматизирована, а качество кода контролируется на каждом коммите.

# Заключение

## Основные достигнутые результаты

* **Оценка востребованности**: подтверждена спросом на основе статистики пилотной iOS-версии PolyMap.
* **Анализ рынка**: выявлены плюсы/минусы существующих решений; по их итогам сформированы **технические требования** платформы.
* **Архитектура**: спроектирована гибкая **микросервисная Serverless-архитектура**, снижая инфраструктурные затраты и упрощая деплой.

  * **Constructor-back** — конструктор карт, авторизация художников, выгрузка карт.
  * **Map-storage** — хранение карт и инвалидация кеша.
  * **Share-back** — короткие ссылки на маршруты/приглашения.
  * **Qr-generator** — генерация стилизованных QR-кодов (растр/вектор).
  * **Web-map-back** — выдача `index.html` с динамическими meta-тегами.
  * **Og-generator** — создание OpenGraph-изображений.
* **Скалирование**: автоматическое горизонтальное и географическое благодаря Serverless; CDN с автоинвалидацией кеша ускоряет загрузку карт.
* **Технологический стек**: Yandex Cloud (выбор обоснован СППР), Vue 3, TypeScript, Bun.js, Hono.

## Разработка веб-версии карты

* Поддержка формата **Extended-IMDF**: кампус-левел и поэтажные планы, поиск, аннотации, сквозная навигация внутри и снаружи.
* Оптимизация под мобильные и десктопы; WebGL + динамическая частота кадров дают высокую производительность и энергоэффективность.

## Инфраструктура и качество

* **CI/CD**: Terraform (IaC), GitHub Actions, ESLint, Bun Test, Cypress E2E в изолированной среде; автоматический деплой и повторные тесты; подробные отчёты о качестве кода.

## Практическое подтверждение

* Весна 2024: три студенческие команды СПб Политеха создали интерактивные планы корпусов 1, 2, 11 и НИК.
* Работа в новой версии конструктора с разными правами доступа; результаты сразу были доступны в веб-карте.
* Успешное выполнение и интеграция карт продемонстрировали востребованность и качество платформы.

## Планы развития

* **Коммерциализация** и привлечение новых заказчиков.
* **3D-поддержка**: новый формат и конструктор объёмных карт (в веб-версии 3D-рендер уже частично готов).
* **Личный кабинет заказчика**: оплата, управление картами, аналитика.
* Долгосрочно — **Indoor-позиционирование** через BLE-маяки + датчики пожарной безопасности для отображения очагов пожара и расчёта путей эвакуации в реальном времени.
