# This app utilizes function to calculate area of a rectangle
# It allows area calculations of n rectangles given by user

# Define func
function area_rectangle {
	read -p "Enter width: " width
	read -p "Enter length: " length
	area=$[width*length]
	echo ">>> Area of rectangle = $area square units"
}

# Main program
read -p "How many rectangles would you like to calculate areas? " n
for (( count=1; count<=$n; count++ ))
do
	printf "No.$count\n"
	area_rectangle
done