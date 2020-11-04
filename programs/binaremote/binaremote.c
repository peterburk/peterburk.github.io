/*
 * binaremote.c
 * Copyright (C) Peter Burkimsher
 *
 * Authors: Peter Burkimsher, peterburk@gmail.com
 *
 * Last modified: 4 Nov 2020, Peter
 * First revision: 2020, Peter
 * 
 * Reference: To compile and run on command line
cc -lcurses binaremote.c -o binaremote
./binaremote
 * 
 * Actions reference:
 * AAA On, state reset
 * AAB Volume down
 * ABA Channel up
 * ABB Channel down
 * BAA Brightness up
 * BAB Brightness down
 * BBA Volume up
 * BBB Off
 *
 * To do:
 * • Testing on other platforms (only known to work on 2014 MacBook Pro 10.13.6)
 * • Repeat the input code a second time for verification
 * • Quiet mode: Only print the actions, not the state
 * • Multiple threads, screen output separate to button input
 * • Another state machine describing the current TV volume level, channel, brightness
 * • Timeout to reset state if no button is pressed for 5 seconds
 * • Infrared remote output to go to a real TV
 * 
 * Done:
 * • Reading button presses without enter (ncurses)
 * • Parsing the input code as a string
 * • Adding pushed buttons to a queue
 * • Displaying messages about current state and future options to user
 * • Entering other characters returns to default state
 */


#include <stdio.h>	 /* Standard input/output definitions */
#include <ncurses.h> /* ncurses is used for keyboard interaction */
#include <stdlib.h>
#include <string.h>  /* String function definitions */

// Node is an item in the queue
// It contains a value (data) and pointer to the next node (next)
struct Node { 
	int data; 
	struct Node *next; 
}; 

// Queue has pointers to the front node and the last node, and the size. 
// front is used for reading the most recent key pressed. 
// last is currently unused. 
// size is used to know how many keys have been pressed to get to the current state. 
struct Queue { 
	struct Node *front; 
	struct Node *last; 
	unsigned int size; 
}; 

/*
 * initQueue: Set the queue front and end to NULL, and size to 0. 
 * @params: struct Queue* thisQueue: The queue
 * @return void
 */
void initQueue(struct Queue *thisQueue) { 
	thisQueue->front = NULL; 
	thisQueue->last = NULL; 
	thisQueue->size = 0; 
} // end initQueue

/*
 * frontNode: Get a pointer to the first node in the queue. 
 * @params: struct Queue* thisQueue: The queue
 * @return struct Node*: The first node in the queue
 */
struct Node* frontNode(struct Queue *thisQueue) { 
	return thisQueue->front; 
} // end frontNode

/*
 * queueLength: Get the value of the first node in the queue. 
 * @params: struct Queue* thisQueue: The queue
 * @return int: The value of the first node in the queue
 */
int frontValue(struct Queue *thisQueue) { 
	return thisQueue->front->data; 
} // end frontValue

/*
 * queueLength: Get the length of the queue. 
 * @params: struct Queue* thisQueue: The queue
 * @return int: The number of nodes in the queue
 */
int queueLength(struct Queue *thisQueue) { 
	return thisQueue->size; 
} // end queueLength

/*
 * popFromQueue: Remove a node from the front of the queue
 * @params: struct Queue* thisQueue: The queue
 * @return void
*/
void popFromQueue(struct Queue *thisQueue) { 
	thisQueue->size--; 
 
	struct Node *tmp = thisQueue->front; 
	thisQueue->front = thisQueue->front->next; 
	free(tmp); 
} // end popFromQueue
 
/*
 * pushToQueue: Add a new node to the end of the queue with a certain value
 * @params: struct Queue* thisQueue: The queue
 *          int data: The value of the new node
 * @return void
 */
void pushToQueue(struct Queue *thisQueue, int data) { 
	thisQueue->size++; 
 
	if (thisQueue->front == NULL) { 
		thisQueue->front = (struct Node *) malloc(sizeof(struct Node)); 
		thisQueue->front->data = data; 
		thisQueue->front->next = NULL; 
		thisQueue->last = thisQueue->front; 
	} else { 
		thisQueue->last->next = (struct Node *) malloc(sizeof(struct Node)); 
		thisQueue->last->next->data = data; 
		thisQueue->last->next->next = NULL; 
		thisQueue->last = thisQueue->last->next; 
	} 
} // end pushToQueue

/*
 * readQueueAtIndex: Read the value of a node in the queue. 
 * @params: struct Node* thisNode: The node in the queue
 *          int numberBitsRemaining: How many more nodes to step along in the queue
 * @return int: The value of the node (0 or 1) if found, -1 if not found
 */
int readQueueAtIndex(struct Node* thisNode, int numberBitsRemaining)
{
	// If there are no more bits, return
	if (numberBitsRemaining == 0)
	{
		return thisNode->data;
		
	} else {
		struct Node* nextNode = thisNode->next;
		
		// If there is no node after this in the queue, return an error
		if (nextNode == NULL)
		{
			return -1;
		}
		
		// How many more bits do we have until we get to the queue offset?
		numberBitsRemaining--;
		
		// Recursively go through the queue
		return readQueueAtIndex(nextNode, numberBitsRemaining);
		
	} // end recursively read the next bit
	
} // end readQueueAtIndex

/*
 * readQueueToString: Combine the queue values into a text string. 
 * @params: struct Queue* thisQueue: The queue
 *          int numberBitsRemaining: How many more bits to read from the queue
 *          char* returnBitString: A pointer to the string we append to. (malloc/free should be handled by the calling function)
 * @return int: 1 if found, 0 if not found
 */
void readQueueToString(struct Queue* thisQueue, int numberBitsRemaining, char* returnBitString)
{
	// Read the bit from the front of the queue
	int thisBit = frontValue(thisQueue);
	
	// Append the bit to the end of the string
	sprintf(returnBitString,"%s%d", returnBitString, thisBit);
	
	// Pop the bit off the queue
	popFromQueue(thisQueue); 
	
	// How many more bits do we have until we finish reading the string?
	numberBitsRemaining--;
	
	// If there are more bits, recurse
	if (numberBitsRemaining > 0)
	{
		return readQueueToString(thisQueue, numberBitsRemaining, returnBitString);
	} // end recursively read the next bit
	
} // end readQueueToString

/*
 * contains: Does thisText contain searchString?
 * @params: char* thisText: The string to search in
 *          char* searchString: The string to search for
 * @return int: 1 if found, 0 if not found
 */
int contains(char* thisText, char* searchString)
{
	if (strstr(thisText, searchString) != NULL)
	{
		return 1;
	} else {
		return 0;
	}
} // end contains

/*
 * printMessage: Read the queue, understand the state, and tell the user what they can do next. 
 * @params: struct Queue* thisQueue: Number of arguments
 * @return void
 */
void printMessage(struct Queue* thisQueue)
{
	int numberBitsEntered = queueLength(thisQueue);
	int bitZero;
	int bitOne;

	if (numberBitsEntered == 0)
	{
		printw("Default state\n");
		printw("Queue: empty\n");
		printw("Press AAA for On/reset\n");
		printw("Press AAB for Volume Down\n");
		printw("Press ABA for Channel up\n");
		printw("Press ABB for Channel down\n");
		printw("Press BAA for Brightness up\n");
		printw("Press BAB for Brightness down\n");
		printw("Press BBA for Volume up\n");
		printw("Press BBB for Off\n");
	} // end if no buttons were pressed (on/reset)

	// Actions clear the queue. Action messages are displayed from the main thread. 
	//int bitTwo = readQueueAtIndex(frontNode(thisQueue), 2);
	//printw("%d\n", bitTwo);

	if (numberBitsEntered == 1)
	{
		bitZero = readQueueAtIndex(frontNode(thisQueue), 0);
		
		printw("Queue: %d\n", bitZero);
		
		// If the first button is A
		if (bitZero == 0)
		{
			printw("Press AA for On/reset\n");
			printw("Press AB for Volume Down\n");
			printw("Press BA for Channel up\n");
			printw("Press BB for Channel down\n");
		} // end if the first button is A
		
		// If the first button is B
		if (bitZero == 1)
		{
			printw("Press AA for Brightness up\n");
			printw("Press AB for Brightness down\n");
			printw("Press BA for Volume up\n");
			printw("Press BB for Off\n");
		} // end if the first button is A
		
	} // end if this is the first button pressed
	
	
	if (numberBitsEntered == 2)
	{
		bitZero = readQueueAtIndex(frontNode(thisQueue), 0);
		bitOne = readQueueAtIndex(frontNode(thisQueue), 1);
		
		printw("Queue: %d, %d\n", bitZero, bitOne);
		
		// If the input is AA
		if ((bitZero == 0) && (bitOne == 0))
		{
			printw("Press A for On/reset\n");
			printw("Press B for Volume Down\n");
		}
		
		// If the input is AB
		if ((bitZero == 0) && (bitOne == 1))
		{
			printw("Press A for Channel up\n");
			printw("Press B for Channel down\n");
		} // end if the first button is A
		
		// If the input is BA
		if ((bitZero == 1) && (bitOne == 0))
		{
			printw("Press A for Brightness up\n");
			printw("Press B for Brightness down\n");
		}
		
		// If the input is BB
		if ((bitZero == 1) && (bitOne == 1))
		{
			printw("Press A for Volume up\n");
			printw("Press B for Off\n");
		} // end if the first button is A
		
	} // end if this is the second button pressed
	
	printw("Press x to exit\n");
	
} // end printMessage

/*
 * main: Wait for user to press buttons, and show actions on the screen. 
 * @params: int argc: Number of arguments
 *			char* argv[]: String arguments. Currently unused. 
 * @return int: Error code (1 if port not opened, 0 if no errors)
 */
int main(int argc, char *argv[]) 
{
	WINDOW *outputScreen;
	int inputChar;
	struct Queue keysQueue; 
	
	// We read bits in groups of 3
	int numberBitsToRead = 3;
	
	// Initialise the return bit string as a fixed-length array on the stack
	//char returnBitStringArray[numberBitsToRead];
	//char* returnBitString = returnBitStringArray;
	
	// Initialise the return bit string dynamically on the heap (needs free at the end)
	char* returnBitString = malloc(numberBitsToRead);
	
	// Initialise the queue
	initQueue(&keysQueue); 
	
	// Initialise the ncurses screen
	initscr();
	noecho();
	cbreak();
	keypad(stdscr, TRUE); // Parse arrow keys as KEY_UP and KEY_DOWN
	printw("BinaRemote v. 1.0 - Press x to quit.\n");
	
	// printMessage with an empty queue will show the default state message
	printMessage(&keysQueue);
	
	// Refresh the ncurses screen (print it to the terminal)
	refresh();
	
	// Read new input characters until the user exits by pressing 'x'
	while ((inputChar = getch()) != 'x') 
	{
		// If a character is pressed. getch() runs often, and ERR is the default if nothing is pressed. 
		if(inputChar != ERR)
		{
		
			// Any new input clears the screen
			clear();
			
			switch(inputChar)
			{
			
				// If A, a, 0, the up arrow, or the mouse scrollwheel up are entered,
				// display "A pressed", push 0 to the queue, and print a message. 
			
				case 'A':
				case 'a':
				case '0':
				case KEY_UP:
					printw("A pressed\n");
					pushToQueue(&keysQueue, 0); 
					printMessage(&keysQueue);
				break;
				
				// If B, b, 1, the down arrow, or the mouse scrollwheel down are entered,
				// display "B pressed", push 1 to the queue, and print a message. 
			
				case 'B':
				case 'b':
				case '1':
				case KEY_DOWN:
					printw("B pressed\n");
					pushToQueue(&keysQueue, 1); 
					printMessage(&keysQueue);
				break;
				
				// If anything else is typed, ignore it. 
				
				default:
					printw("Unknown key pressed\n");
					printMessage(&keysQueue);
				break;
			} // end switch(inputChar)
			
		} // end if inputChar !== ERR
		
		// In theory, the queue could be longer, so we should only clear the first 3 bits (for each command)
		if (queueLength(&keysQueue) >= numberBitsToRead)
		{
			// readQueueToString will popFromQueue, not only read values. 
			readQueueToString(&keysQueue, numberBitsToRead, returnBitString);
			
			// Print the return string as parsed by readQueueToString
			//printw("%s pressed\n", returnBitString);
			
			// clear tells ncurses to erase the screen. 
			clear();
			
			// printMessage with an empty queue will show the default state message
			printMessage(&keysQueue);
			
			// I implemented this as string comparisons just to show that I know how to handle strings in C. 
			if (contains(returnBitString, "000") == 1)
			{
				printw("ACTION: TV ON\n");
			}

			if (contains(returnBitString, "001") == 1)
			{
				printw("ACTION: Volume-\n");
			}

			if (contains(returnBitString, "010") == 1)
			{
				printw("ACTION: Channel+\n");
			}
			
			if (contains(returnBitString, "011") == 1)
			{
				printw("ACTION: Channel-\n");
			}

			if (contains(returnBitString, "100") == 1)
			{
				printw("ACTION: Brightness+\n");
			}
			
			if (contains(returnBitString, "101") == 1)
			{
				printw("ACTION: Brightness-\n");
			}

			if (contains(returnBitString, "110") == 1)
			{
				printw("ACTION: Volume+\n");
			}

			if (contains(returnBitString, "111") == 1)
			{
				printw("ACTION: Off\n");
			}

			// Clear the return string
			sprintf(returnBitString, "");
			
		} // end if 3 keys were read
		
		
		
	} // end while reading inputChar != x
	
	// Free up the memory used by the string, when allocated using malloc
	free(returnBitString);
	
	// Close down the ncurses window
	delwin(outputScreen);
	endwin();
	
} // end main
