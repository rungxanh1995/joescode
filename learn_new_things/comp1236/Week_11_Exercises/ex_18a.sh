# Ask user for input of wall width and length
read -p "Enter wall width in ft: " wallWidth
read -p "Enter wall length in ft: " wallLength

# Output area of wall
wallArea=$(($wallWidth*$wallLength))
echo "Area of the wall is $wallArea square ft."