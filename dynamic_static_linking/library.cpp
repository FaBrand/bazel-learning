#include "library.h"
#include <iostream>

Library::Library() = default;
void Library::HelloWorld() const noexcept
{
    std::cout << "Hello World!" << std::endl;
};
