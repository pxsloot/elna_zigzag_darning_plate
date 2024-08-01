/*
  Elna Zig Zag darning plate
  A small metal formed plate that covers the transport dogs,
  used in combination with the darning foot.
  This enables the user to move the fabric freely under the needle,
  putting down stitches all over the place.

  These things are unobtainium, or via etsy for around $95
  
  This is a 3d printed replacement, prints in 10 minutes and costs
  a few cents. Knock off the corners with a file or sandpaper
*/


$fn=90;

// how much the inside of the plate sticks out above the needle plate.
// there's not much room needed, just to give the transport dogs some
// room to move unobstructed.
//
// too low (<2.4mm) and the transport dogs will lift the plate up.
// it needs some height so the darning foot can apply pressure on the
// fabric and hold it in place
h=3.5;

// needle plate dimensions
plate_w=15;
plate_d=25;

// stub length 
// they register in the needle plate of the machine. Not too short,
// not too long
stub_h=2.0;

thickness=1;

w=plate_w+thickness*2;
d=plate_d+thickness*2;

difference() {
  // form the outside, then carve out what's not needed
  union() {
    cube([w,d,h],center=true);

    // these form the features that register in the
    // notches on the machine
    translate([0,-(plate_d/2-4),-stub_h/2])
      cube([w,2,stub_h+h], center=true);
    translate([0, (plate_d/2-2),-stub_h/2])
      cube([w,2,stub_h+h], center=true);
  }
  
  // slot for the needle. Elongated to make zigzag possible
  translate([0,(plate_d/2-11.5),0])
    hull() {
      translate([3,0,0])
        cylinder(h=30,d=3,center=true);
      translate([-3,0,0])
        cylinder(h=30,d=3,center=true);
    }

  // hollow out the underside. A bit slanted to make it somewhat
  // sturdier. I hope
  carve_h=h*2+stub_h;
  translate([0,0,-(carve_h-thickness)/2])
    rotate([0,180,0])
      linear_extrude(height=carve_h, center=true, scale=1.15)
        square([plate_w,plate_d], center=true);
};


