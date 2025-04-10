#!/bin/bash

# Test1: Missing parameters
echo "Test1: Missing parameters"
output=$(./maze 2>&1)
if [[ $output == *"Usage: ./maze <filename>"* ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test2: File not exist
echo "Test2: File not exist"
output=$(./maze not_found.txt 2>&1)
if [[ $output == *"File not found"* ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test3: Small maze(4*4)
echo "Test3: Small maze(4*4)"
output=$(./maze test_data/smallMaze.txt 2>&1)
if [[ $output == *"Invalid dimensions"* ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test4: Move
echo "Text4: Move"
./maze test_data_validMaze.txt < test_data/test4input.txt > test4output.txt 2>&1

declare -a expected_keywords=(
	"Move right"
	"Move down"
	"Move up"
	"Move left"
)
for keyword in "${expected_keywords[@]}"; do
	if ! grep -q "$keyword" test4output.txt: then
		echo "fall"
	fi
done

echo "pass"
rm text4output.txt

# Test5: Hit wall
echo "Test5: Hit wall"
output=$(echo -e "a" | ./maze test_data/hitWallMaze.txt)
if [[ $output == *"Can't move"* ]]; then
        echo "pass"
else
        echo "fail"
fi

# Test6&7: Open map & Map update
run_maze() {
	local maze_file="$1"
	local input_sequence="$2"
	echo -e "$input_sequence" | ./maze "$maze_file"
}

echo "Test6: Open map"
output=$(run_maze "test_data/validMaze.txt" "M\nQ")
if [[ $output == *"X"* && $output == *"#######"* ]]; then
	echo "pass"
else
	echo "fail"
fi

echo "Test7: Map update"
output=$(run_maze "test_data/validMaze.txt" "D\nM\nQ")
if [[ $output == * X* ]]; then
	echo "pass"
else
	echo "fail"
fi
rm test6&7_maze.txt

# Test8: Success
echo "Test8: Success"

output=$(echo -e "D" | ./maze test_data/test8maze.txt)
if [[ $output == *"Congratulations"* ]] && [[ $? -eq 0 ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test9: Move after success
echo "Test9: Move after success"
output=$(echo -e "D\nD" | ./maze test_data/test8maze.txt 2>&1)
if [[ $output != *"Move right"* ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test10: Invalid input
echo "Test10: Invalid input"
output=$(echo -e "z" | ./maze test_data/test8maze.txt)
if [[ $output == "Invalid input" ]]; then
	echo "pass"
else
	echo "fail"
fi

# Test11: Quit
echo "Test11: Quit"
output=$(echo "Q" | ./maze test_data/validMaze.txt 2>&1)
exit_code=$?

if [ $exit_code -ne 0 ]; then
	echo "Q fail to quit"
	exit 1
fi

if ! echo "$output" | grep -q "Exiting game"; then
	echo "Q fail to show exit prompt"
	exit 1
fi

output=$(echo "q" | ./maze test_data/validMaze.txt 2>&1)
exit_code=$?

if [ $exit_code -ne 0 ]; then
        echo "q fail to quit"
        exit 1
fi

if ! echo "$output" | grep -q "Exiting game"; then
        echo "q fail to show exit prompt"
        exit 1
fi

echo "pass"
exit 0
