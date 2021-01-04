# This app asks user to input their grade on letter scale A-F
# Then decides their grade range within 0-100 for each letter range

# Ask user for grade input
read -p "Enter your grade in letter (A-F): " letter_grade

# Disregard input casing
shopt -s nocasematch

# Switch cases
case $letter_grade in
	"a" )
	# A grade is within 90-100 range
	echo "Grade $letter_grade ranges from 90 to 100.";;
	"b" )
	# B grade is within 80-89 range
	echo "Grade $letter_grade ranges from 80 to 89.";;
	"c" )
	# C grade is within 70-79 range
	echo "Grade $letter_grade ranges from 70 to 79.";;
	"d" )
	# D grade is within 60-69 range
	echo "Grade $letter_grade ranges from 60 to 69.";;
	"f" )
	# F grade is within 0-59 range
	echo "Grade $letter_grade ranges from 0 to 59.";;
esac