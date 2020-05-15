module case_filled (length=14.1, width=5.4, height=1.0, inset=0.25, inscribed_sides=12)
{
    angle = 360 / inscribed_sides;
    side_length = sqrt(4*width*width + height*height);
    radius = 2*sin(90 - angle/2) * side_length / sin(angle);
    difference() 
    {
        cube([length/2, width/2, height/2], center=true);
        translate([0, width/2, radius]) rotate ([0, 90, 0]) cylinder(r=radius, h=length, $fn=360, center=true);
    }
}

module case (shell_thickness=0.125, length=14.1, width=5.4, height=1.0, inset=0.25, inscribed_sides=12)
{
    echo(length);
    difference()
    {
        case_filled (length=length,
                     width=width,
                     height=height,
                     inset=inset,
                     inscribed_sides=inscribed_sides);
        translate([0, 0, shell_thickness / 2])
            case_filled (length = (length - shell_thickness),
                         width = (width - shell_thickness),
                         height = height,
                         inset = (inset - shell_thickness),
                         inscribed_sides = inscribed_sides);
    }
}

module keyboard (length=14.1, width=5.4, height=1.0, inset=0.25, inscribed_sides=12)
{
    case(length = length,
         width = width,
         height = height,
         inset = inset,
         inscribed_sides = inscribed_sides);
}

keyboard ();
