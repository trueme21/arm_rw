CC = /tools/Xilinx/SDK/2018.3/gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-g++

INCLUDES  := 
LIBRARIES := /tools/Xilinx/SDK/2018.3/gnu/aarch64/lin/aarch64-linux/aarch64-linux-gnu/libc/lib

CCFLAGS := -O3 -march=armv8-a+simd -static 
CXXFLAGS := -std=c++11

LIBS := -lgomp

################################################################################
# Source file directory:
#SRC_DIR = src
SRC_DIR = .
# Object file directory:
OBJ_DIR = bin
# Include header file diretory:
INC_DIR = include

## Make variables ##
# Target executable name:
#EXE = main
EXE = run

# Object files:
OBJS = $(OBJ_DIR)/main.o $(OBJ_DIR)/backward_simd.o $(OBJ_DIR)/forward_simd.o $(OBJ_DIR)/ndp_sls.o

##########################################################
## Compile ##

# Link c++ compiled object files to target executable:
#$(EXE) : $(OBJS)
$(EXE) : test.c
	$(EXEC) $(CC) $(CCFLAGS) -o $@ $+ -L$(LIBRARIES) $(LIBS)

# Compile main.c file to object files:
$(OBJ_DIR)/%.o : %.c
	$(EXEC) $(CC) $(CCFLAGS) -c $< -o $@

# Compile C++ source files to object files:
#$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp $(INC_DIR)/%.h
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.c $(INC_DIR)/%.h
	$(CC) $(CCFLAGS) $(CXXFLAGS) -c $< -o $@ -L$(LIBRARIES) $(LIBS)

# Clean objects in object directory.
clean:
	$(RM) bin/* *.o $(EXE)

