// https://openjscad.xyz/
const { cylinder, cuboid } = require('@jscad/modeling').primitives
const { intersect, subtract, union } = require('@jscad/modeling').booleans

const main = (params) => {
  const external = cylinder({radius: 12, height: 5.2, center: [0, 0, 0], segments: 64})
  const cr2032 = cylinder({radius: 10, height: 3.2, center: [0, 0, 0], segments: 64})
  const result = subtract(external, cr2032)
  const insert = cuboid({size: [24, 24, 5.2], center: [12, 0, 5.2/2]})
  const result2 = subtract(result, insert)
  const hole1 = cylinder({radius: 0.5, height: 5.2, center: [-6, +2.5, 0], segments: 64})
  const hole2 = cylinder({radius: 0.5, height: 5.2, center: [-6, 0, 0], segments: 64})
  const hole3 = cylinder({radius: 0.5, height: 5.2, center: [-6, -2.5, 0], segments: 64})
  const holes = union(hole1,hole2, hole3)
  const result3 = subtract(result2, holes)
  return result3
}

module.exports = { main }
