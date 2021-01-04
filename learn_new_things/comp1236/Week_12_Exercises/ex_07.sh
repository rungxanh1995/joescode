# This app compare input number with a constant number
# Then notifies result of the comparison

# Declare constant
readonly const_number=100

# Ask input from user
read -p "Enter your number: " number

# If-else comparison
if [ $number -eq $const_number ]
then
	echo "Right on! Congrats!"
elif [ $number -gt $const_number ]
then
	echo "Guess lower next time!"
else
	echo "Guess higher next time!"
fi