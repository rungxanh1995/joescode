# Exercise 9
# This app keeps asking user for username
# It only stops when matching username is entered
# Then outputs welcome msg in the end

# Declare vars
username=0
# Get real name of user
read -p "Enter your name: " name
# Until loop to compare name vs username
until [ $username == $name ]
do
	read -p "Enter username: " username
done
# Welcome message
echo "Welcome to your account $name!"
