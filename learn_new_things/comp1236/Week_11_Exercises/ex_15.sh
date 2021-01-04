read -p "Enter length of cube's edge: " edge
let surface_one_side=$edge**2
let surface_cube=$surface_one_side*6
let volume_cube=$edge**3
echo "Surface of one side is: $surface_one_side square units."
echo "Surface of cube is:     $surface_cube square units."
echo "Volume of cube is:      $volume_cube cubic units."