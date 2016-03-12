# Luefter - fan control for fursuit heads

Copyright (c) 2016, by Joerg Reuter <jreuter@yaina.de>

*This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.*


This is a small fun project to experiment with the ATtiny family of Atmel microcontrollers. The requirement was a fan controller for a fursuit costume head. The 40×40×10mm 5V Fans are fitted in the opening of the ears of the head and blowing air into the inside. There are four speed modes: off, auto (based on temperature), low, medium and high.

Fans with PWM input (or even only being PWM safe) at this size and voltage are near impossible to find, thus it takes a bit of experimentation to find a working PWM frequency. The timer dividers used by the firmware are for an ATtiny45 and may need adjustment for other types.

## Q&A

1. Why assembler and not C?

"Because I can." Also, the Atmel C library assumes some things (such as using the first timer for delay loops) that may get into the way.  And the linker script adds some overhead, mostly, wasting one word on the stack just to jump to main(). The program does not need much stack, in fact, only one word during interrupts. The macros will cause some code duplication, but these little controllers have plenty of flash space.

From the author's point of view, writing it in C would result in quite
similar code but won't be more readable or maintainable.

2. That button press handling is weird

INT0 is level triggered, which makes key press events a bit annoying.  And it has to happein in an interrupt service routing, so no busy loops and moving part of the state machine to the watchdog timer interrupt service routing. 
 
3. What's the purpose of the LED code?

Debugging. Each interrupt will toggle an LED that can be attached to PB3

4. Isn't it a bit overengineered for the purpose?

Of course, but the first thing to fail will be the fastening for the batteries, I'm afraid. And the next thing to break are the fans - that's why it is important to keep everything detachable. The added complexity does not add significant risk of failure. 
 
The voltage regulator for the 5V is drawing at least 10 mA, this could be improved (the author forgot to order a p-channel MOSFET in time), the L239D is completely oversized for these kinds of fans (n-channel MOSFET switches would be sufficient, but the author thought he could get fans that work in both directions when he designed the circuit.) It won't be needed at all for fans with PWM input, but again, good luck finding those. The whole circuit with both fans running at full speed draws about 350 mA.  
