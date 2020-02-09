board_width = 25.83;
board_length = 91.54;
board_thickness = 1.75;

//these should be largely unnecessary, except clearance
holder_length = 77;
holder_width = 21;
holder_tolerance = 1;
holder_clearance = 20;

pin_start_distance = 14.6;
pin_edge_distance = 2.2;
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
pin_hole = 1.2;

$fn = 120;

brim_height = 0.2;
brim_distance = 0.2;
brim_r=5;

tab_width = 4.5;
tab_height = 4.5;
tab_depth = 1;

tube_r = 2;
tube_thickness = 2.5;
tube_tolerance = 0.2;

port_start = 55;
port_width = 10;
port_height = 3;

switch_start = board_length - 16;
switch_width = 9;
switch_height = 3;

module mirrored () {
  union () {
    children();
    mirror([1,0]) children();
  }
}

module pogo_jig() {
  difference () {
    union() {
      linear_extrude(pin_grasp_length) hull() mirrored()
        translate([board_length/2-outer_corner_r,0]) circle(r=outer_corner_r);
      mirrored() translate([board_length/2-outer_corner_r,0]) {
        linear_extrude(brim_height) circle(r=brim_r);
        linear_extrude(pin_grasp_length+pin_press_length) circle(r=outer_corner_r);
        linear_extrude(pin_grasp_length+pin_press_length+board_thickness) circle(r=corner_hole_radius - peg_tolerance);
      }
      translate([1,outer_corner_r+tab_depth/2-.1,pin_grasp_length-(tab_height-pin_press_length)/2]) cube([tab_width,tab_depth+.2,tab_height-pin_press_length],center=true);
      translate([1-tab_width/2,outer_corner_r+tab_depth-0.4,0]) cube([tab_width,0.8,pin_grasp_length-(tab_height-pin_press_length)-0.2]);
    }
    translate([0,0,-.5]) linear_extrude(pin_grasp_length+1) mirror([1,0,0]) union() {
      for (x=pin_positions) {
        translate([-board_length/2+pin_start_distance+pin_pitch*x, -outer_corner_r+pin_edge_distance]) {
          circle(d=pin_hole);
          translate([-0.1,-5]) square([0.2,5]);
        }
      }
    }
  }
}

module tube_cavity() {
  offset(delta=tube_tolerance) hull () {
    translate([-board_width/2+tube_r,board_width/2-tube_r,]) circle(r=tube_r);
    translate([-board_width/2+tube_r,-board_width/2+tube_r]) circle(r=tube_r);
    circle(d=board_width);
  }
}

module battery_tube() {
  difference() {
    linear_extrude(board_length,convexity=10) difference () {
      offset(delta=tube_thickness) tube_cavity();
      tube_cavity();
    };
    translate([-board_width/2,-board_width/2-tube_thickness-1,port_start])
      cube([port_height,tube_r+tube_thickness+1,port_width]);
    translate([-board_width/2,-board_width/2-1,port_start])
      cube([port_height,1+tube_r,board_length-port_start+1]);
    translate([-board_width/2,board_width/2-tube_r,switch_start])
      cube([switch_height,tube_r+tube_thickness+1,switch_width]);
    translate([-board_width/2,board_width/2-tube_r,switch_start])
      cube([switch_height,1+tube_r,board_length-switch_start+1]);
    translate([-board_width/2-1,board_width/2-tube_r-1,switch_start])
      cube([switch_height+1,tube_r,board_length-switch_start+1]);
  }
}
battery_tube();
/*intersection() {
  translate([0,0,-86]) battery_tube();
  translate([-50,-50,0]) cube([100,100,5]);
}*/
