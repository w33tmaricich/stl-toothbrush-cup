// Alexander Maricich 2018

// fragment size. Number of sides.
$fn=50;

// Cup values.
cup_diameter = 62;
cup_height = 150;
cup_differential = 6;
cup_thickness = 6;
cup_hole_diameter = 3;

// Lid values.
lid_height = 2*cup_differential;  // must be taller than the cup_differential

// Grid values.
grid_gaps = 15;
grid_thickness=6;


// Create the cup
module toothbrush_cup() {
    difference() {
        // Outer cup
        cylinder(cup_height,
                 cup_diameter-cup_differential,
                 cup_diameter+cup_differential,
                 true);
         
        // Cut-out
        translate([0,0,cup_thickness]) cylinder(cup_height,
                cup_diameter-cup_differential-cup_thickness,
                cup_diameter+cup_differential-cup_thickness,
                true);
        
        translate([0,0,10]) cylinder(cup_height,
                 d=cup_hole_diameter,
                 center=true);
    }
}

//toothbrush_cup();

// Create the lid
module solid_lid() {
    difference() {
        // Outer lid
        cylinder(lid_height,
                 d=cup_diameter+cup_differential,
                 true);
         
        // Cut-out
        translate([0,0,-cup_thickness]) cylinder(lid_height,
                d=cup_diameter+cup_differential-cup_thickness,
                true);
    }
}

module hole_lid() {
    difference() {
        solid_lid();
         
        // Cut-out
        cylinder(cup_thickness*3,
                d=cup_diameter+cup_differential-cup_thickness,
                true);
    }
}

module toothbrush_lid() {
    difference() {
        solid_lid();
    }
}

//toothbrush_lid();

module bars() {
    for (i = [0:3]) {
        translate([0, i*(grid_gaps+grid_thickness) ,0]) {
            cube([cup_diameter, grid_thickness, cup_height], true);
        }
    }
    for (i = [0:3]) {
        translate([0, -i*(grid_gaps+grid_thickness) ,0]) {
            cube([cup_diameter, grid_thickness, cup_height], true);
        }
    }
}

module grid() {
    union() {
        translate([0,0,cup_thickness]) bars();
        rotate([0,0,90]) translate([0,0,cup_thickness]) bars();
    }
}

module toothbrush_lid() {
    union() {
        hole_lid();
        intersection() {
            solid_lid();
            grid();
        }
    }
}

//toothbrush_lid();
//toothbrush_cup();