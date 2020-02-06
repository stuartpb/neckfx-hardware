board_width = 26;
board_length = 92;
board_thickness = 1.75;

//these should be largely unnecessary, except clearance
holder_length = 77;
holder_width = 21;
holder_tolerance = 1;
holder_clearance = 20;

pin_start_distance = 15;
pin_edge_distance = 2;
pin_pitch = 2.54;

// 12 and 14 are extra 3v3 and Ground pins
// we leave them out to avoid print issues
pin_positions = [0:15];

corner_hole_diameter = 3;
corner_hole_radius = corner_hole_diameter/2;
corner_hole_inset_radius = 0.66;
outer_corner_r = corner_hole_diameter/2 + corner_hole_inset_radius;
peg_tolerance = 0.1;

pin_grasp_length = 5;
pin_press_length = 2.5;
pin_hole = 1.25;

$fs=0.25;

brim_height = 0.2;
brim_r=5;

tab_width = 4.5;
tab_height = 4.5;
tab_depth = 1.25;

module quadranted () {
  union () {
    //children();
    //mirror([1,0]) children();
    mirror([0,1]) children();
    rotate(180) children();
  }
}

difference () {
  union() {
    linear_extrude(pin_grasp_length) hull() quadranted()
      translate([board_length/2-outer_corner_r,board_width/2-outer_corner_r]) circle(r=outer_corner_r);
    quadranted() translate([board_length/2-outer_corner_r,board_width/2-outer_corner_r]) {
      linear_extrude(brim_height) circle(r=brim_r);
      linear_extrude(pin_grasp_length+pin_press_length) circle(r=outer_corner_r);
      linear_extrude(pin_grasp_length+pin_press_length+board_thickness) circle(r=corner_hole_radius - peg_tolerance);
    }
    // HACK: these coordinates should be less magic
    translate([1,-8-3/15,pin_grasp_length-(tab_height-pin_press_length)/2]) cube([tab_width,tab_depth+2/15,tab_height-pin_press_length],center=true);
  }
  translate([0,0,-.5]) linear_extrude(pin_grasp_length+1) mirror([1,0,0]) union() {

    for (x=pin_positions) {
      translate([-board_length/2+pin_start_distance+pin_pitch*x, -board_width/2+pin_edge_distance]) {
        circle(d=pin_hole);
        translate([-0.1,-5]) square([0.2,5]);
      }
    }
  }
}
