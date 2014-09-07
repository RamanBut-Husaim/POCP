-------------------------------------------------------------------------------
--
-- Title       : Equator
-- Design      : logical_function
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : i:\Embedded\_Projects\Lab01_Eq\logical_function\src\Equator.vhd
-- Generated   : Sun Sep  7 17:57:49 2014
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
--{entity {Equator} architecture {beh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Equator is
	port(
		in1, in2, in3: in std_logic;
		Q: inout std_logic;
		nQ: out std_logic
		);
end Equator;

--}} End of automatically maintained section

architecture beh of Equator is
begin
	Q <= ((in1 and in2) or in3) and (not in2);
	nQ <= not Q;
end beh;
