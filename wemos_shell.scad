board_width = 26;
board_length = 92;
board_thickness = 1.75;

//these should be largely unnecessary, except clearance
holder_length = 77;
holder_width = 21;
holder_tolerance = 1;
holder_clearance = 20;

pin_start_distance = 14.5;
pin_edge_distance = 1.5;
pin_pitch = 2.54;

// 12 and 14 are extra 3v3 and Ground pins
// we leave them out to avoid print issues
pin_positions = [2, 11, 13, 15];

corner_hole_diameter = 3;
corner_hole_radius = corner_hole_diameter/2;
corner_hole_inset_radius = 0.66;
outer_corner_r = corner_hole_diameter/2 + corner_hole_inset_radius;
peg_tolerance = 0.1;

pin_hole = 1.2;

$fs=0.5;

module quadranted () {
  union () {
    children();
    mirror([1,0]) children();
    mirror([0,1]) children();
    rotate(180) children();
  }
}

difference () {
  union() {
    linear_extrude(2) hull() quadranted()
      translate([board_length/2-outer_corner_r,board_width/2-outer_corner_r]) circle(r=outer_corner_r);
    linear_extrude(4) quadranted()
      translate([board_length/2-outer_corner_r,board_width/2-outer_corner_r]) circle(r=corner_hole_radius - peg_tolerance);
  }
  translate([0,0,-.5]) linear_extrude(3) mirror([1,0,0]) union() {
    translate([0,4]) square([holder_length+holder_tolerance,holder_width+2+2*holder_tolerance],center=true);
    translate([holder_length/2-8,-holder_width/2]) square([8,4]);
    for (x=pin_positions) {
      translate([-board_length/2+pin_start_distance+pin_pitch*x, -board_width/2+pin_edge_distance]) circle(d=pin_hole);
    }
  }
  translate ([0,0,2]) cube([board_length+2,12,3],center=true);
}
