#include <fstream>
#include <iostream>
using namespace std;

int main(int argc, char *argv[]) {
    ofstream myfile;
    myfile.open(argv[argc - 1]);
    myfile << "Writing this to a file.\n";
    myfile.close();
    return 0;
}
