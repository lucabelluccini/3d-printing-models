module mirror_copy(v = [1, 0, 0]) {
    children();
    mirror(v) children();
}

caps_count = 5;
columns_count = 5;
cap_head_slot_perc = 0.5;
cap_head_diameter = 37;
cap_head_diameter_margin = 1.5;
cap_head_height = 3;
cap_head_height_margin = 0.5;
cap_neck_diameter = 29.5;
cap_neck_diameter_margin = 1;
cap_neck_thickness = 1.6;
cap_head_diameter_spacing = 2;
backplate_thickness = 1.5;

snap_heigth_min = 5;
snap_heigth_max = 7.5;
snap_width = 3.5;
snap_tickness = 4;


cap_head_d = cap_head_diameter + cap_head_diameter_margin;
cap_head_h = cap_head_height + cap_head_height_margin;
cap_neck_d = cap_neck_diameter + cap_neck_diameter_margin;
gap = (cap_head_d - cap_neck_d) / 2;

//    translate([200*cos(cc*(360/columns_count)),200*sin(cc*(360/columns_count)),0]) {
union() {
    for (cc = [0:columns_count-1]) {
        translate([0,cc*(cap_head_d+cap_head_diameter_spacing*2),0]) {
            difference(){
                union() {
                    linear_extrude(height = (caps_count*cap_head_d), center = true, convexity = 10, twist = 0) {
                        mirror_copy([0,1,0]) {
                            polygon(points=[
                                [0, 0],
                                [0, cap_head_d/2],
                                [cap_head_h, cap_head_d/2],
                                [cap_head_h, cap_head_d/2 - gap],
                                [cap_head_h + cap_neck_thickness, cap_head_d/2 - gap],
                                [cap_head_h + cap_neck_thickness, cap_head_d/2 + cap_head_diameter_spacing],
                                [-backplate_thickness, cap_head_d/2 + cap_head_diameter_spacing],
                                [-backplate_thickness, 0]
                            ]);
                        }
                    }
                    translate([0,0,-(caps_count*cap_head_d)/2+gap/2]) {
                        linear_extrude(height = gap, center = true, convexity = 10, twist = 0) {
                            mirror_copy([0,1,0]) {
                                polygon(points=[
                                    [cap_head_h,0],
                                    [cap_head_h, cap_head_d/2 - gap],
                                    [cap_head_h + cap_neck_thickness, cap_head_d/2 - gap],
                                    [cap_head_h + cap_neck_thickness, 0],
                                ]);
                            }
                        }
                    }
                    translate([0,0,-gap+(caps_count*cap_head_d)/2+gap/2]) {
                        linear_extrude(height = gap, center = true, convexity = 10, twist = 0) {
                            mirror_copy([0,1,0]) {
                                polygon(points=[
                                    [0,cap_head_d/2 - gap],
                                    [0, cap_head_d/2],
                                    [cap_head_h, cap_head_d/2],
                                    [cap_head_h,cap_head_d/2 - gap]
                                ]);
                            }
                        }
                    }
                }
                union() {
                    translate([0,0,(cap_head_d/2)+(cap_head_d*caps_count)/2]) {
                        for (c = [0:caps_count]) {
                            translate([-backplate_thickness,0,-(c*cap_head_d)])
                            rotate([0,90,0])
                            cylinder(h=backplate_thickness, d=cap_neck_d, center=false);
                        }
                    }
                    translate([0,0,-(caps_count*cap_head_d)/2+cap_head_d*cap_head_slot_perc/2+gap]) {
                        linear_extrude(height = cap_head_d*cap_head_slot_perc, center = true, convexity = 10, twist = 0) {
                            mirror_copy([0,1,0]) {
                                polygon(points=[
                                    [cap_head_h,0],
                                    [cap_head_h, cap_head_d/2],
                                    [cap_head_h + cap_neck_thickness, cap_head_d/2],
                                    [cap_head_h + cap_neck_thickness, 0],
                                ]);
                            }
                        }
                    }
                }
            }
        }
    }
    translate([0,0,(cap_head_d/2)+(cap_head_d*caps_count)/2]) {
        for (c = [0:caps_count]) {
            translate([0,-cap_head_d/2 - cap_head_diameter_spacing, -(c*cap_head_d)])
            rotate([90,0,270])   
            linear_extrude(height = snap_tickness, center = true, convexity = 10, twist = 0) {
                mirror_copy([0,1,0]) {
                    polygon(points=[
                        [0, 0],
                        [0, snap_heigth_min],
                        [snap_width, snap_heigth_max],
                        [snap_width, 0]
                    ]);
                }
            }
        }
    }
}

