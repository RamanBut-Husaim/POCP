library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity var2schema is
	port (
		x, y, z: in std_logic;
		f: out std_logic
		);
end var2schema;

architecture Struct of var2schema is
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
	component And3 port (
			a, b, c: in std_logic; 
			z : out std_logic);
	end component;
	component Or3 port (
			a, b, c: in std_logic; 
			z : out std_logic);
	end component;
	signal notX, notY, notZ, t1, t2, t3: std_logic;
begin
	U1: and2 port map (a => x, b => z, z => t1);
	U2: inv port map (a => y, z => notY);
	U3: inv port map (a => x, z => notX);
	U4: inv port map (a => z, z => notZ);
	U5: and2 port map (a => notY, b => z, z => t2);
	U6: and3 port map (a => notX, b => y, c => notZ, z => t3);
	U7: or3 port map (a => t1, b => t2, c => t3, z => f);
end Struct;

architecture Beh of var2schema is
begin
	f <= (x and z) or (not y and z) or (not x and y and not z);
end Beh;