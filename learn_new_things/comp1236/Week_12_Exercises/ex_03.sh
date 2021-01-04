# This app asks user to input 3 integer variables
# Then evaluates their sum and outputs a decision

read -p "Enter integer variable M: " M
read -p "Enter integer variable R: " R
read -p "Enter integer variable T: " T
A=$[M+R+T]
if [ $A -gt 2000 ]
then
	echo "Sum = $A is over 2000."
else
	echo "Sum = $A is 2000 or less."
fi