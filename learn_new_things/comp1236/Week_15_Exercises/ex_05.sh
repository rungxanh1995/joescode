#!/bin/bash
# This script calculates volume of prisms
# There are 2 main funcs: area of cross section, and volume
# Assuming the cross section area of the prisms is a triangle

# Define 2 funcs
function AREA_BASE {
	echo "scale=1; ($1*$2)/2" | bc -l
}
function VOLUME_PRISM {
	echo "scale=1; $1*$2" | bc -l
}

# Main program
read -p "How many prisms would you like to calculate volume? " amount
for ((count=1; count <= amount; count++))
do
	echo "Prism #$count"
	read -p "Enter length: " length
	read -p "Enter width: " width
	read -p "Enter height: " height
	areaBase=$(AREA_BASE $length $width)
	echo ">>> Area of cross section = $areaBase"
	volumePrism=$(VOLUME_PRISM $areaBase $height)
	echo ">>> Volume of prism #$count = $volumePrism"
done
	