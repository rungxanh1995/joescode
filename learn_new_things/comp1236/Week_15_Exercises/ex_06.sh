#!/bin/bash
# Define decision func based on # of params passed
function param_input_decision {
	if [ $# -gt 2 ] || [ $# -eq 0 ]; then
		echo -1
	elif [ $# -eq 1 ]; then
		echo $[$1*2]
	else
		echo $[$1+$2]
	fi
}

# Main program
# Double 1 param
read -p "Enter a number: " single_param
echo "Doubling the number…"
result=$(param_input_decision $single_param)
echo ">>> $single_param doubled = $result"
# Adding 2 params
echo "Next, let’s play adding numbers!"
read -p "Enter 1st number: " num1
read -p "Enter 2nd number: " num2
echo "Adding 2 numbers…"
result=$(param_input_decision $num1 $num2)
echo ">>> $num1 + $num2 = $result"
# Other cases
read -p "Now try entering a 3rd number: " num3
result=$(param_input_decision $num1 $num2 $num3)
echo "Get ready…"
echo ">>> $num1 + $num2 + $num3 = $result. Weird huh!?!"
