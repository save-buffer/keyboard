module curve_cylinder (length, width, height, inscribed_sides)
{
    angle = 360 / inscribed_sides;
    side_length = sqrt(4*width*width + height*height);
    radius = 2*sin(90 - angle/2) * side_length / sin(angle);
    translate([0, width/2, radius]) rotate([0, 90, 0])
        cylinder(r=radius, h=length, $fn=360, center=true);
}

module faceplate_filled (length, width, height, thickness, inscribed_sides)
{
    translate([0, 0, thickness/2]) intersection()
    {
        cube ([length/2, width/2, height/2], center=true);
        difference()
        {
            translate([0, 0, -thickness])
                curve_cylinder (length=length,
                                width=width,
                                height=height,
                                inscribed_sides=inscribed_sides);
            
            curve_cylinder (length=length,
                            width=width,
                            height=height,
                            inscribed_sides=inscribed_sides);
        }
    }
}

module main_keys_hole (length, width, height, thickness, shell_thickness, inscribed_sides)
{
    hole_length = 7 * length/8;
    hole_width = 5 * width/8;
    intersection()
    {
        // TODO: Move this to the right spot
        cube([hole_length/2, hole_width/2, height + thickness], center=true);

        faceplate_filled (length = length,
                          width = width,
                          height = height,
                          thickness = thickness,
                          inscribed_sides = inscribed_sides);
    }
}

module faceplate (length, width, height, thickness, shell_thickness, inscribed_sides)
{
    difference()
    {
        faceplate_filled (length = length,
                          width = width,
                          height = height,
                          thickness = thickness,
                          inscribed_sides = inscribed_sides);
        main_keys_hole (length = length,
                        width = width,
                        height = height,
                        thickness = thickness,
                        shell_thickness = shell_thickness,
                        inscribed_sides = inscribed_sides);
    }
}


module case_filled (length, width, height, inscribed_sides)
{
    difference() 
    {
        cube ([length/2, width/2, height/2], center=true);
        curve_cylinder (length=length,
                        width=width,
                        height=height,
                        inscribed_sides=inscribed_sides);
    }
}

module case (length, width, height, inscribed_sides, shell_thickness)
{
    difference()
    {
        case_filled (length=length,
                     width=width,
                     height=height,
                     inscribed_sides=inscribed_sides);

        translate([0, 0, shell_thickness / 2])
            case_filled (length = (length - shell_thickness),
                         width = (width - shell_thickness),
                         height = height,
                         inscribed_sides = inscribed_sides);
    }
}

module keyboard (length=14.1,
                 width=5.4,
                 height=1.0,
                 inscribed_sides=12,
                 faceplate_thickness=0.05,
                 shell_thickness=0.125,
                 fkeys=true)
{
    translate([0, 0, 1]) color([1, 0, 0])
        faceplate (length = length,
                   width = width,
                   height = height,
                   thickness = faceplate_thickness,
                   shell_thickness = shell_thickness,
                   inscribed_sides = inscribed_sides);
    
    case(length = length,
             width = width,
             height = height,
             inscribed_sides = inscribed_sides,
             shell_thickness=shell_thickness);
}

keyboard ();
