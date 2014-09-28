library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D_Enable_Latch is
	port (
		D : in std_logic;
		Q : out std_logic;
		nQ : out std_logic
		);
end D_Enable_Latch;

architecture Struct of D_Enable_Latch is 
	component nor2 
		port (
			a, b: in std_logic;
			z : out std_logic);
	end component;
	component inv
		port (
			a: in std_logic;
			z: out std_logic);
	end component;
	signal t1, t2, t3 : std_logic;
begin
	U1: inv port map (a => D, z => t3);
	U2: nor2 port map (a => D, b => t2, z => t1);
	U3: nor2 port map (a => t3, b => t1, z => t2);
	Q <= t2;
	nQ <= t1;
end Struct;