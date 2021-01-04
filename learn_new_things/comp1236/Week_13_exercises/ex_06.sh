# Exercise 6
# This app asks user to enter 10 number
# Then finds and prints <sum of positive numbers> & <product of negative numbers>

# Declare vars
sum_positive=0; product_negative=1
# For loop for 10 inputs
for ((i=1; i<=10; i++))
do
	printf "$i.\tEnter any number: "
	read number
	# Calculate sum of positive ints
	if [ $number -gt 0 ]
	then
		sum_positive=$[sum_positive+number]
	# Calculate product of negative ints
	elif [ $number -lt 0 ]
	then
		product_negative=$(($product_negative*$number))
	fi
done
# Output results
echo
echo "Sum of positive numbers: $sum_positive"
echo "Product of negative numbers: $product_negative"