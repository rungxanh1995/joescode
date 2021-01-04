read -p "Enter first number: " num1
read -p "Enter second number: " num2
let sum=$num1+$num2
let diff=$num1-$num2
let product=$num1*$num2
let quotient=$num1/$num2
let remainder=$num1%$num2
echo "Their sum is: $sum"
echo "Their difference is: $diff"
echo "Their product is: $product"
echo "Their quotient is: $quotient"
echo "The remainder of their division is: $remainder"