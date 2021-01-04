# Ask user for input of wall width and length
read -p "Enter wall width in ft: " wallWidth
read -p "Enter wall length in ft: " wallLength

# Output area of wall
wallArea=$(($wallWidth*$wallLength))
echo "Area of the wall is $wallArea square ft."

# Ask user for paint price
read -p "Dollar price for 1 gallon of paint: " gallonPrice

# Calculate number of gallons based on wall area
numGallons=$(echo "scale=2; $wallArea/350" | bc -l)

# Calculate cost
cost=$(echo "scale=2; $numGallons*$gallonPrice)" | bc -l)

# Output number of gallons & cost
echo "You need $numGallons gallons of paint to cover the whole wall."
echo "Cost of paint job is $cost dollars."