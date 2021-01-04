# This script is modded from ex_01.sh
# It returns the area instead of echoing# Define func for calculation

# Define func
function area_rectangle {
	return $[$1 * $2]
}

# Main program
# Ask user input for number of rectangles
read -p "How many rectangles would you like to calculate areas? " n
for (( count=1; count<=$n; count++ ))
do
	printf "Rectangle #$count\n"
	read -p "Enter width: " width
	read -p "Enter length: " length
	printf "Calculating…\n"
	area_rectangle $width $length
	echo ">>> Area of this rectangle = $?"
done