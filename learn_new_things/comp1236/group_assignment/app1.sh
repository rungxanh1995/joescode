# Program 1

# © Joe Pham (101276573) on 2020-11-18

# This program asks the user to input an interger number
# It outputs a list of even multiples of that number
# Users also can indicate how many multiples they want in output

# Ask input from user
echo -e "Welcome to Program 1\n"
read -p "Please enter a number to multiply: " number
read -p "How many even multiples would you like to print out: " amount_to_print

# Print acknowledgement statement
echo "List of first $amount_to_print even multiples of $number is:"
# Iterate over number of times to output multiples
for ((i=1; i<=amount_to_print; i++))
do
	# Handle even/odd input to calculate multiples
	if (($number%2==0))
	then
		# Output for even input number
		echo $(($number*i))
	else
		# Output for odd input number
		echo $(($number*2*i))
	fi
	# This ternary code does the same, stashing here just in case
	# echo $((number % 2 == 0 ? number*i : number*2*i))
done