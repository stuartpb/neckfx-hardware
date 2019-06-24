pin_pitch = 2.54; // how evenly spaced the pins are
shell_width = 3; // space for GPIO 2
pin_length = 7;
end_thickness = 0;
pin_hold = 3;
pin_gauge = 0.9;
buck_out = 3;
buck_bottom = 5.75;
overshot = 1;

block_width = buck_out+pin_hold+pin_length+end_thickness;
block_height = pin_length + 5.5 * pin_pitch;

difference() {
  translate([-buck_out,0,0])
    cube([block_width,
      3* pin_pitch,
      block_height]);
  translate([-buck_out-overshot,-overshot,buck_bottom])
    cube([buck_out+overshot,
      3* pin_pitch + 2*overshot,
      block_height]);
  // buck vin channel
  translate([-buck_out-overshot,-pin_pitch/2,-overshot])
    cube([buck_out+pin_hold+2*overshot,
      pin_pitch,
      block_height + 2*overshot]);
  // buck vout channel
  translate([-buck_out-overshot,pin_pitch-pin_gauge/2,-overshot])
    cube([block_width+2*overshot,
      pin_gauge,
      pin_length+pin_pitch/2+overshot]);
  // buck ground channel
  translate([-buck_out-overshot,pin_pitch*2-pin_gauge/2,-overshot])
    cube([block_width+2*overshot,
      pin_gauge,
      pin_length+pin_pitch/2+overshot]);
  // chip spacer
  translate([-overshot,pin_pitch/2-overshot,pin_length + 1.5*pin_pitch])
    cube([pin_hold+overshot,
      2*pin_pitch+overshot,
      4*pin_pitch+overshot]);
  // chip vcc channel
  translate([pin_hold-overshot, pin_pitch-pin_gauge/2,
    pin_length + 1.5*pin_pitch])
    cube([pin_length+overshot,
      pin_gauge,
      4*pin_pitch+overshot]);
  // chip gnd/gpio channel
  translate([pin_hold-overshot, pin_pitch*2-pin_gauge/2,
    pin_length + 1.5*pin_pitch])
    cube([pin_length+overshot,
      pin_gauge,
      4*pin_pitch+overshot]);
  // vcc pin channel
  #translate([pin_hold, pin_pitch-pin_gauge/2,
    pin_length + pin_pitch/2-overshot])
    cube([pin_length+end_thickness+overshot,
      pin_gauge,
      pin_pitch+overshot]);
  // gnd pin channel
  translate([pin_hold, pin_pitch*2-pin_gauge/2,
    pin_length+ pin_pitch/2-overshot])
    cube([pin_length+end_thickness+overshot,
      pin_gauge,
      pin_pitch+overshot]);
  // vcc pin hole
  translate([-overshot, pin_pitch-pin_gauge/2,
    pin_length+pin_pitch-pin_gauge/2])
    cube([pin_length+pin_hold+end_thickness+2*overshot,
      pin_gauge,
      pin_gauge]);
  // gnd pin hole
  translate([-overshot, pin_pitch*2-pin_gauge/2,
    pin_length+pin_pitch-pin_gauge/2])
    cube([pin_length+pin_hold+end_thickness+2*overshot,
      pin_gauge,
      pin_gauge]);
  // gpio2 carveout
  translate([pin_hold-overshot, pin_pitch*1.5,
    pin_length+2.5*pin_pitch-(shell_width-pin_pitch)/2])
    cube([pin_length+end_thickness+2*overshot,
      pin_pitch,
      shell_width]);
}