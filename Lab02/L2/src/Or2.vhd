library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OR2 is
	port (
	a, b: in std_logic;
	z : out std_logic
	);
end OR2;
architecture Arch of OR2 is
begin
	Z <= a or b;
end Arch;