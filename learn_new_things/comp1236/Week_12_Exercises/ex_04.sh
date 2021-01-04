# This app asks input of a number
# Then outputs its square if square is bigger than 90

read -p "Enter a number: " number
square=$[number**2]
if (($square > 90))
then
	echo "Square value is $square (>90)."
fi