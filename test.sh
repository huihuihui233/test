#!/bin/bash

# Test 1: Missing parameters
echo "Test 1: Missing parameters"
output=$(./maze 2>&1)
if [[ $output == *"Usage: ./maze <filename>"* ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test 2: File not exist
echo "Test 1: File not exist"
output=$(./maze not_found.txt 2>&1)
if [[ $output == *"File not found"* ]]; then
	echo "pass"
else
	echo "fail"
fi


