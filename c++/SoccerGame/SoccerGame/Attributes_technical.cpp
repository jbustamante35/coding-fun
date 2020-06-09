#include <string>
#include <iostream>

class Attributes_technical {
public:
	Attributes_technical(int ctrl, int hnd, int shrp, int lngp, int fsht, int lsht, int crs, int tckl, int pos)
		:ball_control(ctrl), ball_handling(hnd), passing_short(shrp), passing_long(lngp),
		shot_short(fsht), shot_long(lsht), crossing(crs), tackling(tckl), positioning(pos)
	{

	}

private:
	int ball_control;
	int ball_handling;
	int passing_short;
	int passing_long;
	int shot_short;
	int shot_long;
	int crossing;
	int tackling;
	int positioning;
};