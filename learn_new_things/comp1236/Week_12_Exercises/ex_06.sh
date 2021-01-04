# This app struct includes 4 if statements
# It asks input of an integer
# 1st if: state fact if integer >= 11
# 2nd if: state fact if integer <= 111
# 3rd if: state fact if 11 <= integer <= 111
# 4th if: state fact if integer=11 or integer=111

# Declare 2 constant bounds
readonly low_bound=11
readonly high_bound=111

# Ask user for input
read -p "Enter an integer: " number
# 1st if
if [ $number -ge $low_bound ]
then echo "Fact 1. $number is greater than or equal to $low_bound."
fi
# 2nd if
if [ $number -le $high_bound ]
then echo "Fact 2. $number is less than or equal to $high_bound."
fi
# 3rd if
if [ $number -ge $low_bound ] && [ $number -le $high_bound ]
then echo "Fact 3. $number is within the bounds of $low_bound & $high_bound."
fi
# 4th if
if [ $number -eq $low_bound ] || [ $number -eq $high_bound ]
then echo "Fact 4. $number is equal to 1 of the 2 bounds: $low_bound & $high_bound."
fi