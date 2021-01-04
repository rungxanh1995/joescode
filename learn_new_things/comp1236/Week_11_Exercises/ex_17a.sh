read -p "Width of room floor (ft): " roomWidth
read -p "Length of room floor (ft): " roomLength

# Print out floor area in square feet
roomArea=$(($roomWidth*$roomLength))
echo "Area of the floor is: $roomArea square ft."