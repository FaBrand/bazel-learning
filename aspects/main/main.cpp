#include "module1/source1.hpp"
#include "module2/source2.hpp"
#include "module3/source3.hpp"
#include "module4/source4.hpp"
#include "module5/source5.hpp"

int main(int argc, char *argv[])
{
    Source1 a{};
    Source2 b{};
    Source3 c{};
    Source4 d{};
    Source5 e{};
    a.HelloWorld();
    return 0;
}
