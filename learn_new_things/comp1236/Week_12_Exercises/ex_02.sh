# This app is modded from ex_01.sh
# It asks user to input 2 numbers
# If 1st num is even then app outputs their product
# Otherwise it outputs remainder of their division

printf "Enter first number: "
read firstNum
printf "Enter second number: "
read secondNum
if (($firstNum%2==0))
then
	echo "Since $firstNum is even, their product is $[$firstNum*$secondNum]"
else
	echo "Since $firstNum is not even, the remainder of their division is is $[$firstNum%$secondNum]"
fi
