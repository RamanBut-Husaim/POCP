library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity var1schema is
	port (
		x, y, z: in std_logic;
		f: out std_logic
		);
end var1schema;

architecture Struct of var1schema is
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
	signal notX, notY, notZ, t1, t2, t3: std_logic;
begin
	U1: inv port map (a => y, z => notY);
	U2: inv port map (a => x, z => notX);
	U3: inv port map (a => z, z => notZ);
	U4: or2 port map (a => x, b => notY, z => t1);
	U5: and2 port map (a => t1, b => z, z => t2);
	U6: and3 port map (a => notX, b => y, c => notZ, z => t3);
	U7: or2 port map (a => t2, b => t3, z => f);
end Struct;

architecture Beh of var1schema is
begin
	f <= ((x or not y) and z) or (not x and not y and not z);
end Beh;