# It asks input for integer numbers a and b
# Then asks no. of terms to print out with amount_to_print
# It then outputs the terms with count & current sum with each added term

# Defaults the app to run repeatedly in an infinite loop
while true
do
	# Print informant statement
	echo "Terms to be calculated go by U(n) = a*n + b (n>0)"
	# Get input from user
	read -p "Please enter a: " a
	read -p "Please enter b: " b
	read -p "How many terms you want to print: " amount_to_print
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
	read -p "Would you like another sequence? (y/n) " should_continue
	# If yes then continue with app-level loop, else break and stop app
	case $should_continue in
		"y"|"Y"|"yes")
			:;;
		*)
			break;;
	esac
done