# This app displays a menu with 3 opts
# Opt 1 displays a greeting
# Opt 2 doubles a number
# Opt 3 exits the program

# Define main funcs
function greeting {
	echo "G’day mate! How’s it going?"
}
function double_num {
	read -p "Enter a number: " number
	double=$[number*2]
	echo "$number doubled equates $double"
}

# Main program
# Option menu
printf "[1]\t[G]reeting\n"
printf "[2]\t[D]ouble a number\n"
echo
printf "[0]\t[E]xit\n"

# Get opt input from user
read -p "Select an option: " menu_opt

# Disregard input casing
shopt -s nocasematch

# Casing for each menu opt
case $menu_opt in
	0 | E ) exit;;
	1 | G ) greeting;;
	2 | D ) double_num;;
	* )
		printf "Oops, wrong selection!\n";;
esac