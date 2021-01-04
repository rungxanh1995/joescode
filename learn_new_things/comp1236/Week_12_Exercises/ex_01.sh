# This app asks user to input 2 numbers
# If 1st num is bigger then app outputs their sum
# Otherwise it outputs their difference

printf "Enter first number: "
read firstNum
printf "Enter second number: "
read secondNum
if (($firstNum > $secondNum))
then
	echo "Since $firstNum is bigger than $secondNum, their sum is $[$firstNum + $secondNum]"
else
	echo "Since $firstNum is not bigger than $secondNum, their difference is $[$secondNum - $firstNum]"
fi
