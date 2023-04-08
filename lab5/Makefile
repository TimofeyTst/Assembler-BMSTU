CXX		  := g++
CXX_FLAGS := -Wall -Wextra -std=c++20 -ggdb

BIN		:= bin
SRC		:= src
INCLUDE	:= include
LIB		:= lib

LIBRARIES	:=
EXECUTABLE	:= main
ASM_FILE := removeDuplicates

all: $(BIN)/$(EXECUTABLE)

run: clean all
	./$(BIN)/$(EXECUTABLE)

# $(BIN)/$(EXECUTABLE): $(SRC)/*.c $(BIN)/$(ASM_FILE).o
# 	$(CXX) $(CXX_FLAGS) -I$(INCLUDE) -L$(LIB) $^ -o $@ $(LIBRARIES) -fno-pie -no-pie

$(BIN)/$(EXECUTABLE): $(BIN)/$(EXECUTABLE).o $(BIN)/$(ASM_FILE).o
	$(CXX) $(CXX_FLAGS) -o $(BIN)/$(EXECUTABLE) $(BIN)/$(ASM_FILE).o $(BIN)/$(EXECUTABLE).o -fno-pie -no-pie


$(BIN)/$(EXECUTABLE).o: $(SRC)/$(EXECUTABLE).c
	$(CXX) $(CXX_FLAGS) -c $(SRC)/$(EXECUTABLE).c -o $(BIN)/$(EXECUTABLE).o


$(BIN)/$(ASM_FILE).o: $(SRC)/$(ASM_FILE).asm
	nasm -f elf64 -l $(BIN)/$(ASM_FILE).lst $(SRC)/$(ASM_FILE).asm -o $(BIN)/$(ASM_FILE).o

clean:
	-rm $(BIN)/*