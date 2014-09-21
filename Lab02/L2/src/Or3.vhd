library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OR3 is
	port (
	a, b, c: in std_logic;
	z : out std_logic
	);
end OR3;
architecture Arch of OR3 is
begin
	Z <= a or b or c;
end Arch;