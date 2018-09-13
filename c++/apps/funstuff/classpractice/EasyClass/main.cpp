#include <iostream>
#include "Num.hpp"
using namespace std;

int main() {
    
    Num nn(20);
    Num mm(0);
    cout << "cout:" << nn.getAge() << " " << mm.getAge() << endl;
    printf("printf: %d %d\n", nn.getAge(), mm.getAge());
    return 0;
};