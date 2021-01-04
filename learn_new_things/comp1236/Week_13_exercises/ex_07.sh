# Exercise 7
# This app finds and prints all square numbers less than 200

# Declare vars
number=0; square_number=0
# Until loop until square nums reaches 200
until [ $square_number -ge 200 ]; do
	# Output square of 0 first
	echo "Square of $number: $square_number"
	# Increment number
	((number++))
	# Start defining square number
	square_number=$[number**2]
done
