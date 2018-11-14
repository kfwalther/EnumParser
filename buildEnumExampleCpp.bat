:: Script to build the SisoEnums.h test program.

:: Build the C++11 example.
g++ -std=c++11 main.cpp -o EnumExample.exe
:: Build the C99 example.
gcc mainC99.c -o EnumExampleC99.exe

