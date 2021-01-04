# Exercise 3
# This app uses a loop to display odd numbers smaller than 10

for ((i=10; i>=1; i--))
do
	if (( i%2!=0 ))
	then
		echo "Odd number: $i."
	fi
done
