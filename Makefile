WARNING = -Wall -Wshadow --pedantic -Wextra -Werror
ERROR = -Wvla -Werror
GCC = gcc -std=c11 -g $(WARNING) $(ERROR) 

SRCS = main.c variables.c
OBJS = $(SRCS:%.c=%.o)

variables: $(OBJS) 
	$(GCC) $(OBJS) -o variables

.c.o: 
	$(GCC) -c $*.c 

testall: test1 test2 test3 test4 test5

test1: variables
	./variables 1 Ace > output1
	diff output1 expected/expected1

test2: variables
	./variables 22 Base > output2
	diff output2 expected/expected2

test3: variables
	./variables 0 California > output3
	diff output3 expected/expected3

test4: variables
	./variables -100 Dumbledore > output4
	diff output4 expected/expected4

test5: variables
	./variables 84108 Elice > output5
	diff output5 expected/expected5

leak: variables
	valgrind ./variables 84108 Elice vial

clean: # remove all machine generated files
	rm -f variables *.o *.txt output*