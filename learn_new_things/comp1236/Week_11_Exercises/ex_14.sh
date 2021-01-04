echo "Enter first number: "
read num1
echo "Enter second number: "
read num2
if ((num1%2==0))
then
	let product=$num1*$num2
	echo "Their product is: $product"
else
	if ((num1>num2))
	then
		let diff=$num1-$num2
	else
		let diff=$num2-$num1
	fi
	echo "Their difference is: $diff"
fi