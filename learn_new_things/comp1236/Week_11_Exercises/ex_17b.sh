read -p "Width of room floor (ft): " roomWidth
read -p "Length of room floor (ft): " roomLength

# Print out floor area in square feet
roomArea=$(($roomWidth*$roomLength))
echo "Area of the floor is: $roomArea square ft."

# Set area of 6-inch square tile
tileSquareFt=`echo 6/12*6/12 | bc -l`

# Calculate number of tiles to tile floor
tileNum=$(echo "scale=0; $roomArea/$tileSquareFt" | bc -l)

# Output number of tiles to tile floor
echo "You'd need $tileNum tiles to tile this floor."