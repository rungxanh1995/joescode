# This app prompts user to enter their favourite colour
# Pre-set choices: blue, yellow, red, orange
# Then it outputs coder's opinion in response

# Ask input for color
echo "Color pallette: blue | yellow | red | orange"
read -p "What's your fav out of these 4? " color

# Disregard casing of input to simplify switch cases
shopt -s nocasematch
# Switch cases
case $color in
	"blue" )
		echo "I'm not really fond of $color.";;
	"yellow" )
		echo "$color shows you're a lively person eh?";;
	"red" )
		echo "You must be a brave one to choose $color!";;
	"orange" )
		echo "$color? Heyyy, great minds think alike!";;
	* )
		echo "Hmm, should've chosen 1 of those 4, but have fun with $color!";;
esac