#ifdef EMULATION
#include <cpp3ds/Window/BottomScreen_emu.hpp>
#endif

#ifndef CPP3DS_BOTTOMSCREEN_HPP
#define CPP3DS_BOTTOMSCREEN_HPP

#include <cpp3ds/Window/Screen.hpp>

#define BOTTOM_FRAME1 0x202118E0
#define BOTTOM_FRAME2 0X20249CF0
#define BOTTOM_WIDTH 320
#define BOTTOM_HEIGHT 240

namespace cpp3ds {
	class BottomScreen: public Screen {
	public:
		BottomScreen(): Screen(BOTTOM_FRAME1, BOTTOM_FRAME2, BOTTOM_WIDTH, BOTTOM_HEIGHT){}
	};
}

#endif
