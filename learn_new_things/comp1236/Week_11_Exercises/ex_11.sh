# Program to output user's age in days by asking years and months old
read -p "How old are you(in years): " age_years
read -p "How many months extra? " months_diff
let age_days=$age_years*365+$months_diff*30
echo "You must be at least $age_days days old."
