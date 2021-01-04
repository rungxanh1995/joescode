# This script is modded from week 14 content
# This app utilizes function to calculate area of a rectangle
# The func uses parameters as input
# It allows area calculations of n rectangles given by user

# Define func for calculation
function area_rectangle {
	((area=$[$1 * $2]))
	echo ">>> Area of rectangle = $area square units"
}

# Main program
# Ask user input for number of rectanglees
read -p "How many rectangles would you like to calculate areas? " n
for (( count=1; count<=$n; count++ ))
do
	printf "No.$count\n"
	read -p "Enter width: " width
	read -p "Enter length: " length
	area_rectangle $width $length
done