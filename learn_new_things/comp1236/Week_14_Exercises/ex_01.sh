# This app utilizes function to double a number

# Define func
function double_num {
	read -p "Enter a number: " number
	double=$[number*2]
	echo ">>> $number doubled equates $double"
}

# Call func
double_num