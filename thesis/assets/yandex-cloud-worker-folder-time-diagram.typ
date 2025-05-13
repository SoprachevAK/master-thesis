#import "@preview/chronos:0.2.1"

#figure(caption: [Диаграмма последовательности для запроса рабочих директорий])[
  #chronos.diagram({
    import chronos: *

    _par("A", display-name: "CI A")
    _par("B", display-name: "CI B")
    _par("YC", display-name: "Yandex Cloud")
    _par("W1", display-name: "Worker 1")
    _par("W2", display-name: "Worker 2")

    _seq("A", "YC", comment: "Request worker", enable-dst: true)
    _seq(
      "YC",
      "W1",
      comment: "Set ID A",
      disable-src: true,
      enable-dst: true,
      lifeline-style: (fill: oklab(95.23%, -0.017, -0.022)),
    )

    _seq("B", "YC", comment: "Request worker", enable-dst: true)
    _seq(
      "YC",
      "W1",
      comment: "Set ID B",
      disable-src: true,
      disable-dst: true,
      enable-dst: true,
      lifeline-style: (fill: oklab(96.77%, -0.046, 0.032)),
    )

    _seq("A", "W1", comment: "Check ID")
    _seq("W1", "A", comment: "ID: B")

    _seq("B", "W1", comment: "Check ID")
    _seq("W1", "B", comment: "ID: B", enable-dst: true)

    _seq("A", "YC", comment: "Request worker", enable-dst: true)
    _seq(
      "YC",
      "W2",
      comment: "Set ID A",
      disable-src: true,
      enable-dst: true,
      lifeline-style: (fill: oklab(95.23%, -0.017, -0.022)),
    )

    _seq("A", "W2", comment: "Check ID")
    _seq("W2", "A", comment: "ID: A", enable-dst: true)


    _seq("B", "YC", comment: "Free worker", enable-dst: true, disable-src: true)
    _seq("YC", "W1", comment: "Reset ID", disable-dst: true, disable-src: true)
    _seq("A", "YC", comment: "Free worker", enable-dst: true, disable-src: true)
    _seq("YC", "W2", comment: "Reset ID", disable-dst: true, disable-src: true)
  })
]<action-directory-worker-diagram>
