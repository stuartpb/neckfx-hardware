pearl_d = 15;
strip_w = 10;
led_w = 5;
led_h = 2;

module exclusion_zone() {
  translate([-pearl_d/6, -pearl_d/2,0]) cube([
    pearl_d/3, (pearl_d-strip_w)/2, pearl_d]);
}

difference() {
  sphere(d = pearl_d);
  linear_extrude(height = led_h, scale = led_w/strip_w) square(strip_w, center=true);
  difference() {
    union() {
      translate([-pearl_d/2, -pearl_d/2,-pearl_d]) cube(pearl_d);
      exclusion_zone();
    }
    rotate([180,0,0]) exclusion_zone();
  }
}