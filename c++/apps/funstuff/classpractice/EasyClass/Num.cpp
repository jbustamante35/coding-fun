#include "Num.hpp"

Num::Num() : num(0) { }
Num::Num(int n) : num(n) { }

int Num::getAge() {
    return num;
}