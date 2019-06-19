pearl_d = 15;
strip_w = 10;
strip_t = 0.5;
led_w = 5;
led_h = 2;
outrig_d = 12;
nearout_h = 4;
farout_h = 2;
endhole_d = 2;
cable_t = 1.75;
cable_w = 5.55;
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
  translate([-strip_w/2,0,0]) cylinder(d = outrig_d, h = nearout_h/2);
}

module near_negative() {
  translate([-(pearl_d-strip_w)/4,0,0])
    linear_extrude(height = led_h, scale = led_w/strip_w)
      square([(strip_w+pearl_d)/2,strip_w], center=true);
  cube([pearl_d,strip_w,strip_t], center=true);
  translate([-pearl_d/2,0,0]) cube([pearl_d,cable_w,cable_t], center=true);
}

module far_positive() {
  common_positive();
  translate([-strip_w/2,0,0]) cylinder(d = outrig_d, h = farout_h/2);
}

module far_negative() {
  translate([-(pearl_d-strip_w)/4,0,0])
    linear_extrude(height = led_h, scale = led_w/strip_w)
      square([(strip_w+pearl_d)/2,strip_w], center=true);
  cube([pearl_d,strip_w,strip_t], center=true);
  translate([-strip_w/2-outrig_d/2.8,0,0])
    cylinder(d = endhole_d, h = farout_h*2, center=true);
  }

difference() {
  common_positive();
  common_negative();
  difference() {
    union() {
      translate([-pearl_d/2, -pearl_d/2,-pearl_d]) cube(pearl_d);
      exclusion_zone();
      
    }
    rotate([180,0,0]) exclusion_zone();
  }
}
