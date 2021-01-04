# This app is modded from week 14 content
# It returns the doubled value of inputted number

# Define func
function double_num {
	echo $[$number*2]
}

# Main program
read -p "Enter a number: " number
result=$(double_num)
echo ">>> $number doubled = $result"