width_box = 77;
length_box = 77;
tickness = 6;
height_box = 12.6;
buttons_diam = 7;
base_tickness = 3;
slot_diam = 9;
guides = 2;
guides_gap = 0.3;
cap_tickness = 4;
screw_diam = 3.3;
bolt_head_diam = 8;

module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z])
            translate(-pt)
                children();   
}

translate([0, height_box+20, 0]) {
    difference () {
        translate([0, 0, -(width_box)/2]) {
            rotate([90,0,0]) {
                linear_extrude(height = cap_tickness, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                    square(size = [width_box+2*tickness, length_box+2*tickness], center = true);
                }
            }
        }
        union() {
            translate([0,0, -(width_box)/2]) {
                rotate([90,0,0]) {
                    linear_extrude(height = cap_tickness, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                        square(size = [width_box-1.5, length_box-1.5], center = true);
                    }
                }
            }
            for(rot = [0,90,180,270]) {
                rotate_about_pt(0, rot, [0, 0, - width_box/2]) {
                    translate([0, -(guides+guides_gap)/2, tickness/2]) {
                        linear_extrude(height = guides+guides_gap, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                            square(size = [width_box *(3/4), guides+guides_gap], center = true);
                        }
                    }
                    /* vite */
                    translate([width_box/2+tickness/2, 0, tickness/2]) {
                        rotate([90,0,0]) {
                            cylinder(h=cap_tickness, r=screw_diam/2, center =true, $fn=16);
                        }
                    }
                    /* dado */
                    translate([width_box/2+tickness/2, cap_tickness/4, tickness/2]) {
                        rotate([90,0,0]) {
                            cylinder(h=cap_tickness/2, d=bolt_head_diam, center = true, $fn=16);
                        }
                    }
                }
            }
        }
    }
}

difference() {
    union () {
        translate([0,(height_box)/2-base_tickness/2, -(width_box)/2]) {
            rotate([90,0,0]) {
                linear_extrude(height = height_box+base_tickness, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                    square(size = [width_box+2*tickness, length_box+2*tickness], center = true);
                }
            }
        }
        for(rot = [0,90,180,270]) {
            rotate_about_pt(0, rot, [0, 0, - width_box/2]) {
                translate([0,(height_box)+guides/2, tickness/2]) {
                    linear_extrude(height = guides, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                        square(size = [width_box *(3/4), guides], center = true);
                    }
                }
                

            }
        }
    }
    union() {
        translate([0, height_box/2, -width_box/2]) {
            rotate([90,0,0]) {
               union() {
                    linear_extrude(height = height_box+0.4, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                        square(size = [width_box, length_box], center = true);
                    }
                    /* circular hole to save filament */
                    cylinder(h = height_box*2, r1 = width_box/2, r2 = width_box/2, center = true, $fn=32);
                    cube([width_box, length_box*0.7, height_box*2], center = true);
                }
            }
        }
        translate([19, buttons_diam/2, 0]){
            cylinder(h = tickness, r1 = buttons_diam/2, r2 = 3/2, center = false, $fn=16);
        }
        translate([-19,buttons_diam/2,0]){
            cylinder(h = tickness, r1 = buttons_diam/2, r2 = 3/2, center = false, $fn=16);
        }
        translate([0,buttons_diam/2,tickness/2]){
            linear_extrude(height = tickness*2, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0, $fn = 16) {
                square(size = [13, buttons_diam+3], center = true);
            }
        }
        
        
        for(rot = [0,90,180,270]) {
            rotate_about_pt(0, rot, [0, 0, - width_box/2]) {
                
                /* supporto piedi */
                translate([width_box/2-slot_diam/2, -base_tickness, -slot_diam/2]) {
                    rotate([90,0,0]) {
                        cylinder(h=base_tickness/2, d=slot_diam, center =true, $fn=16);
                    }
                }
                /* viti */
                translate([width_box/2+tickness/2, height_box/2-base_tickness/2, tickness/2]) {
                    rotate([90,0,0]) {
                        cylinder(h=height_box+base_tickness, r=screw_diam/2, center =true, $fn=16);
                    }
                }
                
                /* dado */
                translate([width_box/2+tickness/2, -base_tickness, tickness/2]) {
                    rotate([90,0,0]) {
                        cylinder(h=base_tickness/2, d=bolt_head_diam, center = true, $fn=16);
                    }
                }
                
            }
        }
        
        
    }
}

       


