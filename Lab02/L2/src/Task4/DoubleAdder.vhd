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
use	ieee.std_logic_unsigned.all;

entity DoubleAdder is
	Generic (n : integer := 2);
	port(
		a: in std_logic_vector(n-1 downto 0);
		b: in std_logic_vector(n-1 downto 0);
		cIn: in std_logic;
		cOut: out std_logic;
		s : out std_logic_vector(n-1 downto 0) 
	);
end DoubleAdder;
--}} End of automatically maintained section
-- structural description
architecture Struct of DoubleAdder is
	component FullAdder port (
			a, b, cIn: in std_logic;
			s, cOut: out std_logic);
	end component; 
	signal t: std_logic_vector(n-2 downto 0);
begin
	Add_0: FullAdder port map (a(0), b(0), cIn, s(0), t(0));
	SCG: for J in 1 to N-2 Generate
		Add_j: FullAdder port map (a(j), b(j), t(j-1), s(j), t(j));
	end generate;
	Add_Final: FullAdder port map (a(n-1), b(n-1), t(n-2), s(n-1), cOut);
end Struct;
--behavioral description.
architecture Beh of DoubleAdder is
	signal sum: std_logic_vector(n downto 0);
begin
	sum <= ('0' & a) + ('0' & b) + cIn;
	s <= sum(n-1 downto 0);
	cOut <= sum(n);
end beh;
