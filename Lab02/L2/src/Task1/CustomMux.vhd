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

entity CustomMux is
	port(
		a1, b1, s1: in std_logic;
		z1: out std_logic
		);
end CustomMux;
--}} End of automatically maintained section
-- structural description
architecture Struct of CustomMux is
	component And2 port (
			a, b: in std_logic; 
			z : out std_logic);
	end component;
	component Or2 
		port (
			a, b: in std_logic;
			z : out std_logic);
	end component;
	component Inv
		port (
			a: in std_logic;
			z: out std_logic);
	end component;
	signal t1, t2, t3: std_logic;
begin
	U1: inv port map (a => s1, z => t1);
	U2: and2 port map (a => a1, b=> t1, z => t2);
	U3: and2 port map (a=> s1, b => b1, z => t3);
	U4: or2 port map (a=> t2, b => t3, z => z1);
end Struct;
--behavioral description.
architecture Beh of CustomMux is
begin
	Z1 <= a1 when s1 = '0' else b1;
end beh;
