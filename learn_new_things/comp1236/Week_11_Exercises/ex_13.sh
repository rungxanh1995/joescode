read -p "Enter 2 numbers: " num1 num2
if ((num1>num2))
then
	let sum=$num1+$num2
	echo "Their sum is: $sum"
else
	let diff=$num2-$num1
	echo "Their difference is: $diff"
fi