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
stub=2.0;

thickness=1;

w=plate_w+thickness*2;
d=plate_d+thickness*2;

// make the part (and place it upside down for printing)
translate([0,0,h/2]) rotate([0,180,0]) difference() {
  // form the outside first, remove what's not needed later
  union() {
    cube([w,d,h],center=true);

    // these form the features that register in the
    // notches in the needleplate on the machine
    translate([0,-(plate_d/2-4),-stub/2])
      cube([w,2,stub+h], center=true);
    translate([0, (plate_d/2-2),-stub/2])
      cube([w,2,stub+h], center=true);
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
  carve_h=h*2+stub;
  translate([0,0,-(carve_h-thickness)/2])
    rotate([0,180,0])
      linear_extrude(height=carve_h, center=true, scale=1.15)
        square([plate_w,plate_d], center=true);

    // Make some chamfers, because we're not animals
    chamfer=1.0;
    angle=30;

    oversize=2;
    h1=h*oversize;
    d1=d*oversize;
    w1=w*oversize;

    // calculate offset
    f=((h1/oversize)/sin(angle))+((h/2-chamfer)/tan(angle));

    translate([-(w/2+f),0,0])
      rotate([0,-angle,0])
        cube([w1,d1,h1], center=true);

    translate([(w/2+f),0,0])
      rotate([0,angle,0])
        cube([w1,d1,h1], center=true);

    translate([0,-(d/2+f),0])
      rotate([angle,0,0])
        cube([w1,d1,h1], center=true);

    translate([0,(d/2+f),0])
      rotate([-angle,0,0])
        cube([w1,d1,h1], center=true);

};
