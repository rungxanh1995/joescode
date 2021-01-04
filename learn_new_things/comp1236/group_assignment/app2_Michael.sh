# Defaults whether or not to continue to "y"
should_continue='y'
# Defaults app loop to iterate infinitely
while ((should_continue == 'y'))
do
    # Declare main vars
    a=0; b=0; amt_to_print=0; sum_of_terms=0

    # Print informant function statement
    echo "===================================================="
	echo -e "Welcome to App 2!\n"
    printf 'Terms would be calculated using U(n) = a*n + b...\n'
    # Get user input
    read -p "Please enter a value for 'a': " a
    read -p "Please enter a value for 'b': " b
    read -p "How many values would you like to print? " amt_to_print

    # Loops through amount of terms to print to calculate value of each term & sum of the terms
    for ((n=1; n <= amt_to_print; n++))
    do
        term_value=$((a*n + b))
        let "sum_of_terms+=$term_value"
        printf "Term value at n = $n: $term_value\n"
    done
    # Outputs the total sum
    printf "Total sum of the terms printed: $sum_of_terms\n"

    # And ask for user input if wish to continue
    should_continue='n'
    read -p "Would you like to enter another sequence? [y/N] " should_continue

    # Handles default value case of should_continue if user left blank
    if [ -z "$should_continue" ]
    then
        should_continue='n'
    fi

    # Forces to lower input of should_continue
    should_continue=$(echo "$should_continue" | awk '{print tolower($0)}')
done