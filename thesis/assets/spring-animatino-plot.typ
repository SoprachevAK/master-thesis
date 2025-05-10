#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/cetz-plot:0.1.1": plot


#let position(dampingRatio: 0.8, frequencyResponse: 0.35, initialVelocity: 0) = x => {
  let mass = 1
  let stiffness = calc.pow(2 * calc.pi / frequencyResponse, 2) * mass
  let dampingCoefficient = 4 * calc.pi * dampingRatio * mass / frequencyResponse
  let λ = dampingCoefficient / mass / 2
  let ω_d = (
    calc.sqrt(stiffness / mass)
      * calc.sqrt(calc.abs(1 - calc.pow(dampingCoefficient / (2 * calc.sqrt(stiffness * mass)), 2)))
  )
  let s_0 = 1
  let v_0 = initialVelocity
  let t = x
  let ζ = dampingCoefficient / (2 * calc.sqrt(stiffness * mass))

  if (calc.abs(ζ - 1) < 1e-6) {
    let c_1 = s_0
    let c_2 = v_0 + λ * s_0

    return calc.exp(-λ * t) * (c_1 + c_2 * t)
  } else if (ζ < 1) {
    let c_1 = s_0
    let c_2 = (v_0 + λ * s_0) / ω_d

    return calc.exp(-λ * t) * (c_1 * calc.cos(ω_d * t) + c_2 * calc.sin(ω_d * t))
  } else {
    let c_1 = (v_0 + s_0 * (λ + ω_d)) / (2 * ω_d)
    let c_2 = s_0 - c_1

    return calc.exp(-λ * t) * (c_1 * calc.exp(ω_d * t) + c_2 * calc.exp(-ω_d * t))
  }
}

#let springEasing(dampingRatio: 0.8, frequencyResponse: 0.35, duration: 1, velocity: 0) = {
  let fn = position(dampingRatio: dampingRatio, frequencyResponse: frequencyResponse, initialVelocity: velocity)
  return p => 1 - fn(p * duration)
}


#let showPlot = (data, label) => {
  canvas({
    import draw: *

    set-style(
      axes: (stroke: .5pt, tick: (stroke: .5pt)),
      legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 50%, anchor: "east"),
    )

    plot.plot(
      size: (11, 8),
      y-tick-step: 0.2,
      x-tick-step: 0.2,
      y-min: 0,
      y-max: 1.5,
      x-label: "t",
      y-label: "x(t)",
      axis-style: "left",
      {
        let domain = (0, 1.5)

        for (dampingRatio, frequencyResponse) in data {
          let fn = springEasing(
            dampingRatio: dampingRatio,
            frequencyResponse: frequencyResponse,
            duration: 1,
            velocity: 0,
          )

          plot.add(
            fn,
            domain: domain,
            label: label(dampingRatio, frequencyResponse),
            samples: 1000,
          )
        }

        plot.add-hline(1, style: (stroke: (dash: "dotted", paint: gray)))
      },
    )
  })
}

#let byDamping = showPlot(
  (
    (0.3, 0.5),
    (0.5, 0.5),
    (0.8, 0.5),
    (1.0, 0.5),
    (1.2, 0.5),
  ),
  (dampingRatio, frequencyResponse) => [$ζ = #dampingRatio$],
)

#let byFrequency = showPlot(
  (
    (0.3, 0.2),
    (0.3, 0.5),
    (0.3, 0.8),
    (0.3, 1.1),
    (0.3, 1.4),
  ),
  (dampingRatio, frequencyResponse) => [$ω = #frequencyResponse$],
)
