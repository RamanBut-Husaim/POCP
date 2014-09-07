-------------------------------------------------------------------------------
--
-- Title       : MultD2
-- Design      : MultMix
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : i:\Embedded\_Projects\Lab01_MultMix\MultMix\src\MultD2.vhd
-- Generated   : Sun Sep  7 19:17:32 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MultD2} architecture {beh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MultD2 is
	port (
		in1: in std_logic;
		in2: in std_logic;
		in3: in std_logic;
		in4: in std_logic;
		s: in std_logic;
		out1, out2: out std_logic
		);
end MultD2;

--}} End of automatically maintained section

architecture beh of MultD2 is
begin
	out1 <= in1 when s='0' else in2;
	out2 <= in3 when s='0' else in4;
end beh;
