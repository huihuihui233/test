#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100
#define MIN_SIZE 5

//maze struct
typedef struct {
	int rows;
	int cols;
	char grid[MAX_SIZE][MIN_SIZE];
	int s_row;
	int s_col;
	int e_row;
	int e_col
} Maze;

//player struct (record player location)
typedef struct {
	int current_row;
	int current_col;
} player;

//initialize maze
Maze load_maze(const char* filename) {
	//Open maze.txt
	//Record the location of "S" and "E"
	//Complete maze.grid
	return maze;
}

//validate maze
int validate_maze(Maze* maze) {
	//Check if the size is within the range of 5-100
	//Check if there is only one 'S' and' E 'present
	//Check if the maze is rectangular
	return 0;
}

//initialize player
Player init_player(Maze* maze) {
	//Initialize player position
	return palyer;
}

//Move
void move_palyer(Maze* maze, Player* player) {
	//Update player coordinates
	//Check if it has crossed the boundary or hit the wall
}

//Victory determination
int check_win_condition(Maze* maze, Player* player) {
	//Compare player coordinates with "E" coordinates
}

//Map
void display_map((Maze* maze, Player* player) {
	//print map
}

//process player input
void process_input(Maze* maze, Player* player) {
	//Reading player input
	//Calling move_player() or display_map()
}

int main(int argc, char* argv[]) {
	//Check parameter
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <maze_file>\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	//Load maze
	Maze game_maze = load_maze(argv[1]);
	if (!validate_maze(&game_maze)) {
		fprintf(stderr, "Invalid maze file\n");
		exit(EXIT_FAILURE);
	}

	//initialize player
	Player player = init_player(&game_maze);

	//game
	while (1) {
		process_input(&game_maze, &player);

		//Victory determination
		if (check_win_condition(&game_maze, &player)) {
			printf("Congratulations! You escaped the maze!\n");
			break;
		}
	}

	return 0;
}