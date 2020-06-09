#include <string>
#include <iostream>
#include "Date.h"

class Profile {
public:
	Profile(Date dob, int h, int w, string f, string c)
		:birthday(dob), height(h), weight(w), foot(f), country(c)
	{

	}

private:
	Date birthday;
	int height;
	int weight;
	string foot;
	string country;
};