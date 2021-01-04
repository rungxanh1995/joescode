# PRINTS GREETINGS
echo "####################################################"
echo "##             WELCOME TO OUR PROJECT             ##"
echo "####################################################"

# 3 MAIN APP FUNCTIONS
# App 1
function app_1 () {
	# © Joe Pham (101276573)

	# This program asks the user to input an interger number
	# It outputs a list of even multiples of that number
	# Users also can indicate how many multiples they want in output

	# Ask input from user
	echo "===================================================="
	echo -e "Welcome to App 1!\n"
	read -p "Please enter a number to multiply: " number
	read -p "How many even multiples you want to print out? " amount_to_print

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
	# End of App 1
}
# App 2	
function app_2 () {
	# © Michael D'Mello (101331770)

	# This app calculates terms under this formula: U(n) = a*n + b (n>0)
	# It asks input for integer numbers a and b
	# Then asks no. of terms to print out with amount_to_print
	# It then outputs the terms with count & current sum with each added term

	# Defaults the app to run repeatedly in an infinite loop
	while true
	do
		# Print informant statement
		echo "===================================================="
		echo -e "Welcome to App 2!\n"
		echo "Terms to be calculated go by U(n) = a*n + b (n>0)"
		# Get input from user
		read -p "Please enter a: " a
		read -p "Please enter b: " b
		read -p "How many terms would you like to print? " amount_to_print
		# Declare counter/n & sum of terms
		n=1; sum_of_terms=0
		# Loop through each count to calculate terms and sums
		for ((n=1; n<=amount_to_print; n++)) do
			term=$[$a*$n+$b]
			((sum_of_terms+=term))
			# Output
			echo -e "At count $n\tTerm = $term\tCurrent sum = $sum_of_terms"
		done
		
		# Ask user if wish to repeat
		read -p "Would you like another sequence? (Y/N) " should_continue
		# If yes then continue with app-level loop, else break and stop app
		case $should_continue in
			"y"|"yes")
				:;;
			*)
				break;;
		esac
	done
	# End of App 2
}
# App 3
function app_3 () {
	# © Minkyu Kim (101003196)

	# This app asks user to enter a maximum value
	# Then generates a list of numbers less than or equal to that max
	# Those numbers are products of non-negative successive integers

	# Ask user for input of maximum value
	echo "===================================================="
	echo -e "Welcome to App 3!\n"
	read -p "Please enter the maximum limit: " max_limit

	# Declare vars
	count=1; int_factor=0; product_number=0

	# Print acknowledgement statement
	echo "List of product numbers less than or equal to $max_limit:"

	# Loop to iterate from 1st count till output number reaches limit
	while [ $product_number -le $max_limit ];
	do
		echo -e "No.$count:\t$product_number\t(product of $int_factor & $[$int_factor+1])"
		let int_factor=$[$int_factor+1]
		let count=$[$count+1]
		let product_number=$[$int_factor*($int_factor+1)]
	done
	# End of App 3
}
# END OF FUNCTION SECTION

# DEFAULTS MAIN PROGRAM TO AN INFINITE LOOP
while true
# RUN PROGRAM-LEVEL LOOP WHILE TRUE
do
	# Program-level menu for app choice
	echo "===================================================="
	printf "THIS PROGRAM CONTAINS 3 APPS:\n"
	echo
	echo -e "[1]\t[M]ultiples"
	echo -e "[2]\t[S]equence"
	echo -e "[3]\t[P]roducts"
	echo
	echo -e "[0]\t[E]xit"
	echo "===================================================="
	
	# Disregard casing of input to simplify switch cases
	shopt -s nocasematch
	
	# Ask user for input of app choice
	read -p "Enter number or 1st letter of your app choice: " app_choice
	# Pass input into 4 switch cases
	case $app_choice in
		"1" | "one" | "m" ) app_1;;
		"2" | "two" | "s" ) app_2;;
		"3" | "three" | "p" ) app_3;;
		"0" | "zero" | "e" )
		# Ask if user wish to exit program
		read -p "Are you sure you want to exit? (Y/N) " should_exit_program
		
		# If no then continue with default true loop, else break loop
		case $should_exit_program in
			"n" | "no" | "nope" )
				echo "Let's see the app choices again, shall we?"
				:;;
			* )
				echo "Have a great day. Goodbye!"
				break;;
		esac
		;;
		# End of [E]xit case
		
		* )
		# Otherwise if input doesn't match any of 4 menu items
		# Say goodbye and break loop
			echo "Have a great day. Goodbye!"
			break;;
	esac
done
# END OF PROGRAM

