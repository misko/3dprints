wave_length=125;
antenna_width=10;
antenna_stalk_width=10-0.25;
antenna_base_length=23;

base_width=wave_length+2*antenna_base_length;
height=antenna_width+8;

ziptie_width=3.5;
ziptie_depth=2.5;

screw_r=5.5/2;
backing=2;
edges=2;

module antenna_cutout() {
    difference() 
    {
            
    //translate([0,0,0]) cube([30,30,height]);    
    union() {
        translate([antenna_width/2+edges+ziptie_depth,antenna_width/2+backing,0]) rotate([0,0,180]) 
            cube([
        antenna_width+ziptie_depth*2+edges*2,
        antenna_base_length+antenna_width/2+backing,
        antenna_width+backing]);
        
        cylinder(height,antenna_width/2+backing,antenna_width/2+backing);
         translate([-(antenna_width+ziptie_depth*2+edges*2)/2,0,0]) cube([antenna_width+ziptie_depth*2+edges*2,
        wave_length-antenna_width-2*backing,3]);
    }
        translate([0,0,antenna_width/2]) antenna();
    }
}

module antenna() {
    //antenna cutout below
    translate([antenna_width/2,antenna_width/2,-antenna_width]) rotate([0,0,180]) cube([antenna_width,antenna_base_length+antenna_width/2,antenna_width]);
    
    //the base antenna
    cylinder(height*4,antenna_stalk_width/2,antenna_stalk_width/2);
    translate([0,antenna_width/2,0]) rotate([90,0,0]) {
        cylinder(antenna_base_length+antenna_width/2,antenna_width/2,antenna_width/2);
        }
    
    
    //a ziptie
    rotate([0,0,180]) translate([antenna_width/2,antenna_width/2+2,-antenna_width]) {
        
        cube([ziptie_depth,ziptie_width,height*2]);
        translate([-antenna_width-ziptie_depth,0,0]) cube([ziptie_depth,ziptie_width,height*2]);
        translate([0,10,0]) {
            cube([ziptie_depth,ziptie_width,height*2]);
            translate([-antenna_width-ziptie_depth,0,0]) cube([ziptie_depth,ziptie_width,height*2]);
        }
    }
}

module screw_hold() {
    difference() {
        cylinder(antenna_width+backing,screw_r+backing,screw_r+backing);
        cylinder(antenna_width+backing,screw_r,screw_r);
    }
}

rotate([0,0,0]) //difference() 
{
    //translate([-base_width/2,-base_width/2,0]) cube([base_width,base_width,height]);
    translate([0,0,0]) {
        translate([0,wave_length/2,0]) rotate([0,0,180]) antenna_cutout();
        translate([0,-wave_length/2,0]) antenna_cutout();
        rotate([0,0,90]) {

            translate([0,wave_length/2,0]) rotate([0,0,180]) antenna_cutout();
            translate([0,-wave_length/2,0]) antenna_cutout();
        }
    }
    
    k1=antenna_width/2+ziptie_depth+(screw_r+backing);
    k2=wave_length/2+antenna_base_length-screw_r*2;
    translate([k1,-k2,0]) screw_hold();
    translate([-k1,k2,0]) screw_hold();
    translate([k2,-k1,0]) screw_hold();
    translate([-k2,k1,0]) screw_hold();
    //z=wave_length*0.9;
    //translate([-z/2,-z/2]) cube([z,z,height*2]);
    
    
    /*translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);
    rotate([0,0,90]) translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);
    rotate([0,0,2*90]) translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);
    rotate([0,0,3*90]) translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);*/
}
//cube([10,20,height]);

