pearl_d = 15;
strip_w = 10;
strip_t = 0.5;
led_w = 5;
led_h = 2;
nearout_w = 12;
nearout_h = 4;
farout_h = 2;
farout_d = 12;
farout_inset = 1.5;
nearhole_d = 2;
nearbump_d = 5;
farhole_d = 2.5;
contact_w = 7.8;
cable_t = 1.75;
cable_w = 5.55;
data_bead = true;

$fn = 90;

module exclusion_zone() {
  intersection () {
    translate([-pearl_d/2, strip_w/2,0])
      cube(pearl_d);
    scale([pearl_d/4,pearl_d/1.9,pearl_d]) cylinder();
  }
}

module common_positive() {
  sphere(d = pearl_d);
}

module common_negative() {
  linear_extrude(height = led_h, scale = led_w/strip_w)
    square(strip_w, center=true);
  cube([pearl_d,strip_w,strip_t], center=true);
}

module near_positive() {
  common_positive();
  translate([-pearl_d,-nearout_w/2,0]) cube([pearl_d,nearout_w,nearout_h/2]);
  translate([-pearl_d*7/8,-nearout_w/2+cable_w/4,0])
    cylinder(d=nearbump_d, h=nearout_h/2);
  translate([-pearl_d*7/8,nearout_w/2-cable_w/4,0])
    cylinder(d=nearbump_d, h=nearout_h/2);
}

module near_negative() {
  linear_extrude(height = led_h, scale = led_w/strip_w)
    square(strip_w, center=true);
  cube([pearl_d*1.5,strip_w,strip_t], center=true);
    translate([-pearl_d/4,0,0]) cube([pearl_d,contact_w,cable_t], center=true);
  translate([-pearl_d/2,0,0]) cube([pearl_d,cable_w,cable_t], center=true);
  translate([-pearl_d*7/8,-nearout_w/2+cable_w/4,0])
    cylinder(d=nearhole_d, h=2*nearout_h, center=true);
  translate([-pearl_d*7/8,nearout_w/2-cable_w/4,0])
    cylinder(d=nearhole_d, h=2*nearout_h, center=true);
}

module far_positive() {
  common_positive();
  translate([-pearl_d/2+farout_inset,0,0]) cylinder(d = farout_d, h = farout_h/2);
  if (data_bead) translate([-pearl_d/2,0,0]) sphere(d = 3.5);
}

module far_negative() {
  translate([-(pearl_d-strip_w)/4,0,0])
    linear_extrude(height = led_h, scale = led_w/strip_w)
      square([(strip_w+pearl_d)/2,strip_w], center=true);
  cube([pearl_d,strip_w,strip_t], center=true);
  translate([-strip_w/2-pearl_d/3,0,0])
    cylinder(d = farhole_d, h = farout_h*2, center=true);
  if (data_bead) {
    translate([-pearl_d/2,0,0]) sphere(d = 2);
    translate([-pearl_d/2-2,-2,-4]) cube(4);
  }
}

difference() {
  near_positive();
  near_negative();
  difference() {
    union() {
      translate([-pearl_d/2, -pearl_d/2,-pearl_d]) cube(pearl_d);
      exclusion_zone();
      
    }
    rotate([180,0,0]) exclusion_zone();
  }
}
