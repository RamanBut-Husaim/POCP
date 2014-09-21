-------------------------------------------------------------------------------
--
-- Title       : CustomMux
-- Design      : L2
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : I:\Embedded\_Projects\POCP\Lab02\L2\src\CustomMux.vhd
-- Generated   : Sun Sep 21 11:11:31 2014
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
--{entity {CustomMux} architecture {Arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FullAdder is
	port(
		a, b, cIn: in std_logic;
		s, cOut: out std_logic
		);
end FullAdder;
--}} End of automatically maintained section
-- structural description
architecture Struct of FullAdder is
	component And2 port (
			a, b: in std_logic; 
			z : out std_logic);
	end component;
	component Xor2 port (
			a, b: in std_logic; 
			z : out std_logic);
	end component;
	component Or2 
		port (
			a, b: in std_logic;
			z : out std_logic);
	end component;
	signal t1, t2, t3: std_logic;
begin
	U1: xor2 port map (a => a, b=> b, z => t1);
	U2: xor2 port map (a => t1, b=> cIn, z => s);
	U3: and2 port map (a => t1, b => cIn, z => t2);
	U4: and2 port map (a => a, b => b, z => t3);
	U5: or2 port map (a => t2, b => t3, z => cOut);
end Struct;
--behavioral description.
architecture Beh of FullAdder is
begin
	s <= ((a xor b) xor cIn);
	cOut <= (a and b) or (cIn and (a or b));
end beh;
