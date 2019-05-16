#include "library.h"
#include <iostream>

Library::Library() = default;

void Library::HelloWorld() const
{
    std::cout << "HelloWorld!" << '\n';
}
