library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MegaMux is
	port (
		a, b: in std_logic;
		a1, b1: in std_logic;
		s: in std_logic;
		z, z1: out std_logic
		);
end MegaMux;

architecture Struct of MegaMux is
	component CustomMux port (
			a1, b1, s1: in std_logic;
			z1: out std_logic
			);
	end component;
begin
	U1: CustomMux port map (
		a1 => a,
		b1 => b,
		s1 => s,
		z1 => z
		);
	U2: CustomMux port map (
		a1 => a1,
		b1 => b1,
		s1 => s,
		z1 => z1
		);
end Struct;

architecture Beh of MegaMux is
begin  
	Z <= a when s = '0' else b;
	Z1 <= a1 when s = '0' else b1;
end Beh;