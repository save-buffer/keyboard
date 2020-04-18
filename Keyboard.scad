module keyboard (length=14.1, width=5.4, height=1.0, inset=0.25, inscribed_sides=12)
{
    angle = 360 / inscribed_sides;
    side_length = sqrt(4*width*width + height*height);
    radius = 2*sin(90 - angle/2) * side_length / sin(angle);
    difference() 
    {
        cube([length, width, height], center=true);
        translate([0, width/2, radius]) rotate ([0, 90, 0]) cylinder(r=radius, h=length, $fn=360, center=true);
    }
}

keyboard ();