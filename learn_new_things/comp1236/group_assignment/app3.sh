# Program 3

# This app asks user to enter a maximum value
# Then generates a list of numbers less than or equal to that max
# Those numbers are products of non-negative successive integers

# Ask user for input of maximum value
echo "Welcome to Program 3!"
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
