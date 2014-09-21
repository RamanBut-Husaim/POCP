library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Xor2 is
	port (
	a, b: in std_logic;
	z : out std_logic
	);
end Xor2;
architecture Arch of Xor2 is
begin
	Z <= a xor b;
end Arch;