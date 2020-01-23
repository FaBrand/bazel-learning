#include <iostream>

extern int constant_in_library;
int main(int argc, char* argv[])
{
    std::cout << "Hello World" << '\n';
    return constant_in_library;
}
