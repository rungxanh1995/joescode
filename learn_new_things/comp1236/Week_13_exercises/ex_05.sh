# Exercise 5
# This app asks user to keep entering numbers till >= 10
# Then calculates and prints sum of all numbers entered while < 10

#Declare vars
number=0; sum=0
# While loop while input is less than 10
while [ $number -lt 10 ]
do
	((sum+=number))
	read -p "Enter a number: " number
done
# Output result
echo "Sum of entered values less than 10 is $sum."