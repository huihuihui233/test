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
echo "Test3:Small maze(4*4)"
cat << EOF > small_maze.tst
####
#S #
# E#
####
EOF
output=$(./maze small_maze.txt 2>&1)
if [[ $output == *"Invalid dimensions"* ]]; then
	echo "pass"
else
	echo "fail"
fi
rm small_maze.txt

# Test4: Move right
echo "Text4: Move right"
cat << EOF > test4_maze.txt
#####
#S  #
#  ##
#  E#
#####
EOF
output=$(echo -e "d\nq" | ./maze text4_maze.txt)
if [[ $output == *"Move right"* ]]; then
	echo "pass"
else
	echo "fail"
fi
rm test4_txt

# Test5: Hit wall
echo "Test5: Hit wall"
cat << EOF > test5_maze.txt                                                            #####
#S  #
#  ##
#  E#
#####
EOF
output=$(echo -e "a" | ./maze text5_maze.txt)
if [[ $output == *"Can't move"* ]]; then
        echo "pass"
else
        echo "fail"
fi
rm test5_txt

# Test6&7: Open map & Map update
run_maze() {
	local maze_file="$1"
	local input_sequence="$2"
	echo -e "$input_sequence" | ./maze "$maze_file"
}
cat << EOF > test6&7_maze.txt                                                          
#######
#S  # #
##  ###
#    ##
###   #
#E  ###
#######
EOF

echo "Test6: Open map"
output=$(run_maze "test6&7_maze.txt" "M\nQ")
if [[ $output == *"X"* && $output == *"#######"* ]]; then
	echo "pass"
else
	echo "fail"
fi

echo "Test7: Map update"
output=$(run_maze "test6&7_maze.txt" "D\nM\nQ")
if [[ $output == * X* ]]; then
	echo "pass"
else
	echo "fail"
fi
rm test6&7_maze.txt


