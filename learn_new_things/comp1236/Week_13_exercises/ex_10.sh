# Exercise 10
# This app is modded from ex_09.sh
# This app keeps asking user for username & password
# It only stops when matching username & password is entered
# Then outputs welcome msg in the end

# Declare vars & constants
input_username=0; input_password=0
readonly username="admin"
readonly password="0000"
# Until loop to compare inputs vs predefined consts
until [ $input_username == $username ] && [ $input_password == $password ]
do
	read -p "Enter username: " input_username
	read -p "Enter password: " input_password
done
# Welcome message
echo "Welcome to your account, $username!"
