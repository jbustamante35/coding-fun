#include <string>
#include <iostream>
#include "Profile.h"
#include "Attributes.h"

class Player {
public:
	Player(string n, Profile p, Attributes_physical phys, Attributes_technical skill)
		:name(n), profile(p), physicalAtts(phys), skillAtts(skill)
	{

	}

private:
	string name;
	Profile profile;
	Attributes_physical physicalAtts;
	Attributes_technical skillAtts;
};