wave_length=125/4;
antenna_width=10;
antenna_base_length=23;

base_width=wave_length+2*antenna_base_length;
height=antenna_width+8;

ziptie_width=3.5;
ziptie_depth=2.5;

screw_r=5.5/2;
backing=2;
edges=5;


module antenna() {
    //antenna cutout below
    translate([antenna_width/2,antenna_width/2,-antenna_width]) rotate([0,0,180]) cube([antenna_width,antenna_base_length+antenna_width/2,antenna_width]);
    
    //the base antenna
    cylinder(height*4,antenna_width/2,antenna_width/2);
    translate([0,antenna_width/2,0]) rotate([90,0,0]) {
        cylinder(antenna_base_length+antenna_width/2,antenna_width/2,antenna_width/2);
        }
    
    
    //a ziptie
    rotate([0,0,180]) translate([antenna_width/2,antenna_width/2,-antenna_width]) {
        
        cube([ziptie_depth,ziptie_width,height*2]);
        translate([-antenna_width-ziptie_depth,0,0]) cube([ziptie_depth,ziptie_width,height*2]);
        translate([0,10,0]) {
            cube([ziptie_depth,ziptie_width,height*2]);
            translate([-antenna_width-ziptie_depth,0,0]) cube([ziptie_depth,ziptie_width,height*2]);
        }
    }
}

antenna_cutout(); 

feet_height=2;
translate([wave_length/2+10,wave_length/2+10,0]) cylinder(feet_height,10,10);
translate([-(wave_length/2+10),wave_length/2+10,0]) cylinder(feet_height,10,10);
translate([-(wave_length/2+10),-(wave_length/2+10),0]) cylinder(feet_height,10,10);
translate([wave_length/2+10,-(wave_length/2+10),0]) cylinder(feet_height,10,10);

rotate([0,180,0]) difference() 
{
    translate([-base_width/2,-base_width/2,0]) cube([base_width,base_width,height]);
    translate([0,0,height/2]) {
        translate([0,wave_length/2,0]) rotate([0,0,180]) antenna();
        translate([0,-wave_length/2,0]) antenna();
        rotate([0,0,90]) {
            translate([0,wave_length/2,0]) rotate([0,0,180]) antenna();
            translate([0,-wave_length/2,0]) antenna();
        }
    }
    
    
    translate([wave_length/2,wave_length/2,0]) cylinder(height,screw_r,screw_r);
    translate([-wave_length/2,wave_length/2,0]) cylinder(height,screw_r,screw_r);
    translate([wave_length/2,-wave_length/2,0]) cylinder(height,screw_r,screw_r);
    translate([-wave_length/2,-wave_length/2,0]) cylinder(height,screw_r,screw_r);
    //z=wave_length*0.9;
    //translate([-z/2,-z/2]) cube([z,z,height*2]);
    
    
    /*translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);
    rotate([0,0,90]) translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);
    rotate([0,0,2*90]) translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);
    rotate([0,0,3*90]) translate([-base_width/2,wave_length/8,-3]) cube([base_width,wave_length/4,height]);*/
}
//cube([10,20,height]);

