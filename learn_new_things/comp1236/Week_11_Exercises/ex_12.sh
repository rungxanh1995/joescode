read -p "Enter a number: " number
let squareNum=$number**2
# Print out the square if it's greater than 90
if ((squareNum>90))
then
	echo "Since its square is bigger than 90, here's that square: $squareNum"
fi