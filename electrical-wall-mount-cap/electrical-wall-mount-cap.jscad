const jscad = require('@jscad/modeling')
const { roundedRectangle, polygon, rectangle, cylinder } = jscad.primitives
const { extrudeLinear } = jscad.extrusions
const { rotateX,rotateY,rotateZ,translate } = jscad.transforms
const { intersect, subtract, union } = jscad.booleans

const getParameterDefinitions = () => {
    return [
        { name: 'length', type: 'int', initial: 150, caption: 'Length?' }, 
        { name: 'width', type: 'int', initial: 100, caption: 'Width?' },
    ]
}

const thickness = 8;
const mwidth = 89.5;
const mheight = 54.5;
const margin = 4.5;
const thickness2 = 1;
const radiusHead = 3.5;
const radiusScrew = 2;
const heightHead = 5;
const distance = 25;
const extCyl = 5;
const thicknessCyl = thickness + 2;

const generateScrew = (distance) => {

    return subtract(wrappingCyl,union(screw, screw2));
}

const main = (params) => {
    const capProfile = roundedRectangle({size: [mwidth, mheight], roundRadius: 5, center: [0, 0], segments: 64})
    const cap = extrudeLinear({ height: thickness }, capProfile)
    const capProfile2 = roundedRectangle({size: [mwidth+(margin*2), mheight+(margin*2)], roundRadius: 7, center: [0, 0], segments: 64})
    const cap2 = extrudeLinear({ height: thickness2 }, capProfile2)
    const capProfile3 = roundedRectangle({size: [mwidth-(margin), mheight-(margin)], roundRadius: 5, center: [0, 0], segments: 64})
    const cap3 = extrudeLinear({ height: thickness/2 }, capProfile3)
    
    const screwA = cylinder({radius: radiusHead, height: heightHead, center: [-distance, 0, heightHead/2], segments: 64})
    const screw2A = cylinder({radius: radiusScrew, height: thicknessCyl, center: [-distance, 0, thicknessCyl/2], segments: 64})
    const wrappingCylA = cylinder({radius: extCyl, height: thicknessCyl, center: [-distance, 0, thicknessCyl/2], segments: 64})
    
    const screwB = cylinder({radius: radiusHead, height: heightHead, center: [distance, 0, heightHead/2], segments: 64})
    const screw2B = cylinder({radius: radiusScrew, height: thicknessCyl, center: [distance, 0, thicknessCyl/2], segments: 64})
    const wrappingCylB = cylinder({radius: extCyl, height: thicknessCyl, center: [distance, 0, thicknessCyl/2], segments: 64})

     
    return subtract(
        union(
          subtract(
            union(cap, cap2), translate([0, 0,  thickness/2], cap3)
          ),
          wrappingCylA,
          wrappingCylB
        ),
        union(screwA, screw2A, screwB, screw2B)
    );
}

module.exports = { main }