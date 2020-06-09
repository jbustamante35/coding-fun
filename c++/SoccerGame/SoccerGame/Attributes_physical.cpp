#include <string>
#include <iostream>

class Attributes_physical {
public:
	Attributes_physical(int str, int spp, int jmp, int vis)
		:strength(str), speed(spp), jump(jmp), vision(vis)
	{

	}

private:
	int strengh;
	int speed;
	int jump;
	int vision;
};