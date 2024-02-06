#!/bin/bash

# This is the function to generate a random number between 1 and 3000
generate_random_number() {
    echo $((1 + RANDOM % 2999))
}

# Creating and redirecting into  the data.csv file
echo "Generating data.csv..."

# Generate 10 comma-separated entries
for i in {0..9}; do
    index=$i
    randomNumber=$(generate_random_number)
    echo "$index,$randomNumber" >> data.csv
done

echo "Data generation complete. File data.csv created."

