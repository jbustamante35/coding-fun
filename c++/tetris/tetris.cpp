/*
 * Simple Tetris Clone
 * From YouTube https://www.youtube.com/watch?v=8OK8_tHeCIA
 * tetris.cpp
 * Copyright (C) 2020 Julian Bustamante <jbustamante35@gmail.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "tetris.h"  */

#include <iostream>
using namespace std;

wstring tetrimino[7];
int fldWidth  = 12;
int fldHeight = 18;
unsigned char *pField = nullptr;

/* Compute rotation index */
int Rotate(int px, int py, int r) {
    switch (r & 4) {
        case 0: return py * 4 + px;        // No rotation
        case 1: return 12 + py - (px * 4); // 90 degrees clockwise
        case 2: return 15 - (py * 4) - px; // 180 degrees clockwise
        case 3: return 3 - py + (px * 4);  // 270 degrees clockwise
    }

    return 0;
}

/* Run Tetris! */
int main() {
   // Create shapes
   // I piece
   tetrimino[0].append(L"..X.");
   tetrimino[0].append(L"..X.");
   tetrimino[0].append(L"..X.");
   tetrimino[0].append(L"..X.");

   // S piece
   tetrimino[1].append(L"..X.");
   tetrimino[1].append(L".XX.");
   tetrimino[1].append(L".X..");
   tetrimino[1].append(L"....");

   // 5 piece
   tetrimino[2].append(L".X..");
   tetrimino[2].append(L".XX.");
   tetrimino[2].append(L"..X.");
   tetrimino[2].append(L"....");

   // Square piece
   tetrimino[3].append(L"....");
   tetrimino[3].append(L".XX.");
   tetrimino[3].append(L".XX.");
   tetrimino[3].append(L"....");

   // T piece
   tetrimino[4].append(L"..X.");
   tetrimino[4].append(L".XX.");
   tetrimino[4].append(L"..X.");
   tetrimino[4].append(L"....");

   // L piece
   tetrimino[5].append(L"....");
   tetrimino[5].append(L".XX.");
   tetrimino[5].append(L"..X.");
   tetrimino[5].append(L"..X.");

   // 7 piece
   tetrimino[6].append(L"....");
   tetrimino[6].append(L".XX.");
   tetrimino[6].append(L".X..");
   tetrimino[6].append(L".X..");

   // Initialize field
   pField = new unsigned char[fldWidth * fldHeight]; // Play field buffer
   for (int x = 0; x < fldW x++)
       for (int y = 0; y < fldHeight y++)
           pField[y * fldWidth + x] = (x == 0 || x == fldWidth - 1 || y == fldHeight - 1) ? 9 : 0


    return 0;
}



