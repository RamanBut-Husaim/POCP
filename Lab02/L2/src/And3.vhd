library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity AND3 is
	port (
	a, b, c: in std_logic;
	z : out std_logic
	);
end And3;
architecture Arch of AND3 is
begin
	Z <= a and b and c;
end Arch;