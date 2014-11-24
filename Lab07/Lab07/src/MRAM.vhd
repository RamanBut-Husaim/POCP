library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MRAM is
	port (
		RW: in std_logic;
		ADR: in std_logic_vector(2 downto 0);
		DIN: in std_logic_vector (7 downto 0);
		DOUT: out std_logic_vector (7 downto 0)
		);
end MRAM;

architecture Beh of MRAM is
	subtype byte is std_logic_vector(7 downto 0);
	type tRAM is array (0 to 7) of byte;
	signal RAM : tRAM :=(
		"00000001",	 -- 000 | a = 1
		"00000010", -- 001 | b = 2
		"00000011", -- 010 | c = 3
		"00000100", -- 011 | x = 4
		"00000000", -- 100 | f
		others => "00000000"
	);
	signal data_in: byte;
	signal data_out: byte;
Begin
	data_in <= Din;
	WRITE: process (RW, ADR, data_in)
	begin
		if (RW = '0') then
			RAM(conv_integer(adr)) <= data_in;
		end if;
	end process; 
	
	data_out <= RAM (conv_integer(adr));
	
	ZBUFS: process (RW, data_out)
	begin
		if (RW = '1') then
			DOUT <= data_out;
		else
			DOUT <= (others => 'Z');
		end if;
	end process;
end Beh;