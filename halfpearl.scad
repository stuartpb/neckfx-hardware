pearl_d = 15;
strip_w = 10;
led_w = 5;
led_h = 2;

$fn = 90;

module exclusion_zone() {
  intersection () {
    translate([-pearl_d/2, strip_w/2,0])
      cube(pearl_d);
    scale([pearl_d/4,pearl_d/1.9,pearl_d]) cylinder();
  }
}

difference() {
  sphere(d = pearl_d);
  linear_extrude(height = led_h, scale = led_w/strip_w) square(strip_w, center=true);
  cube([pearl_d,strip_w,0.5], center=true);
  difference() {
    union() {
      translate([-pearl_d/2, -pearl_d/2,-pearl_d]) cube(pearl_d);
      exclusion_zone();
    }
    rotate([180,0,0]) exclusion_zone();
  }
}
