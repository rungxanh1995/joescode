# Exercise 4
# This app uses a loop to display even numbers up to 10

for ((i=1; i<=10; i++))
do
	if (( i%2==0 ))
	then
		echo "Even number: $i."
	fi
done