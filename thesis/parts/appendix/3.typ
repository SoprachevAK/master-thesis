#import "../../utils/utils.typ": listing
= Реализация функции пружинной интерполяции<spring-interpolation>

#listing("Реализация функции пружинной интерполяции")[
  ```ts
  function springEasing(
    dampingRatio: number,
    frequencyResponse: number,
    duration: number = 1,
    velocity: number = 0) {
    const spring = new DampedHarmonicSpring(dampingRatio, frequencyResponse)
    return (progress: number) => 1 - spring.position(progress * duration, 1, velocity)
  }

  class DampedHarmonicSpring {
    private dampingCoefficient: number
    private mass: number
    private stiffness: number

    constructor(dampingRatio: number, frequencyResponse: number) {
      this.stiffness = Math.pow(2 * Math.PI / frequencyResponse, 2)
      this.dampingCoefficient = 4 * Math.PI * dampingRatio / frequencyResponse
    }

    private get dampingRatio(): number {
      return this.dampingCoefficient / (2 * Math.sqrt(this.stiffness))
    }

    private get dampedNaturalFrequency(): number {
      return Math.sqrt(this.stiffness) * Math.sqrt(Math.abs(1 - Math.pow(this.dampingRatio, 2)))
    }

    position(time: number, initialPosition: number = 1, initialVelocity: number = 0): number {
      const ζ = this.dampingRatio
      const λ = this.dampingCoefficient / 2
      const ω_d = this.dampedNaturalFrequency
      const s_0 = initialPosition
      const v_0 = initialVelocity
      const t = time

      if (Math.abs(ζ - 1) < 1e-6) {
        const c_1 = s_0
        const c_2 = v_0 + λ * s_0

        return Math.exp(-λ * t) * (c_1 + c_2 * t)
      }
      else if (ζ < 1) {
        const c_1 = s_0
        const c_2 = (v_0 + λ * s_0) / ω_d

        return Math.exp(-λ * t) * (c_1 * Math.cos(ω_d * t) + c_2 * Math.sin(ω_d * t))
      }
      else {
        const c_1 = (v_0 + s_0 * (λ + ω_d)) / (2 * ω_d)
        const c_2 = s_0 - c_1

        return Math.exp(-λ * t) * (c_1 * Math.exp(ω_d * t) + c_2 * Math.exp(-ω_d * t))
      }
    }
  }
  ```
]
