# This app asks user to input their grade on scale of 100
# Then decides their grade in letter scores of A-F

# Ask user for grade input
read -p "Enter your grade in scale 0-100: " number_grade
# Declare letter_grade
letter_grade=0
# Decision tree
if [ $number_grade -ge 90 ]
then
	letter_grade="A"
	echo "Your grade is $letter_grade. You must be so proud!"
elif [ $number_grade -ge 80 ] && [ $number_grade -lt 90 ]
then
	letter_grade="B"
	echo "Your grade is $letter_grade. How impressive!"
elif [ $number_grade -ge 70 ] && [ $number_grade -lt 80 ]
then
	letter_grade="C"
	echo "Your grade is $letter_grade. Not that great, but solid effort!"
elif [ $number_grade -ge 60 ] && [ $number_grade -lt 70 ]
then
	letter_grade="D"
	echo "Your grade is $letter_grade. Passed, but you can do much better!"
else
	letter_grade="F"
	echo "Your grade is $letter_grade. Sorry, you gotta repeat the class!"
fi