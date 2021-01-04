# Exercise 8
# This app finds at sums cube numbers
# Condition: 10 < cube_number < 100

# Declare vars
number=0; cube_number=0;
# Declare bound range
readonly low_bound=10; readonly upp_bound=100
# While loop to limit upper bound
while [ $cube_number -lt $upp_bound ]
do
	# Output results from lower bound
	if [ $cube_number -gt $low_bound ]
	then
		echo "Cube of $number: $cube_number"
	fi
	# Increment number
	((number++))
	# Start defining cube_number
	cube_number=$[number**3]
	
done
