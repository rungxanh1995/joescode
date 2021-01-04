echo "Enter number a: "
read num_a
echo "Enter number b: "
read num_b
let a_to_power_b=$num_a**$num_b
let b_to_power_a=$num_b**$num_a
echo "a^b = $num_a^$num_b = $a_to_power_b"
echo "b^a = $num_b^$num_a = $b_to_power_a"