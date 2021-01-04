#!/bin/bash
# This script calculates volume of a prism
# Inputs provided: length, width, height
# Assuming the base area of the prism is a triangle

function VOLUME_PRISM {
	# Volume = 1/2 * length * width * height
	echo "scale=1; ($1*$2*$3)/2" | bc -l
}

echo "Calculate volume of a prism"
read -p "Enter length: " length
read -p "Enter width: " width
read -p "Enter height: " height
result=$(VOLUME_PRISM $length $width $height)
echo ">>> Volume of prism = $result"