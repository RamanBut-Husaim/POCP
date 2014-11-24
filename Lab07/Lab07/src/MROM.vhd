library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

-- LOAD - 000
-- STORE - 001
-- ADD - 010
-- MUL - 011
-- HALT - 100

entity MROM is 
	port (
		RE: in std_logic;
		ADR: in std_logic_vector(2 downto 0);
		DOUT: out std_logic_vector(5 downto 0)
		);
end MROM;

architecture Beh of MROM is
	subtype inst is std_logic_vector(5 downto 0);
	type tROM is array (0 to 7) of inst;
	constant ROM: tROM :=(
	"000" & "000", -- LOAD a
	"011" & "011", -- MUL x
	"010" & "001", -- ADD b
	"011" & "011", -- MUL x
	"010" & "010", -- ADD c
	"001" & "100", -- STORE f
	"100" & "000", -- HALT
	"111" & "111"
	);
	signal data: inst;
begin
	data <= ROM(conv_integer(adr));
	zbufs: process (RE, data)
	begin
		if (RE = '1') then
			DOUT <= data;
		else
			DOUT <= (others => 'Z');
		end if;
	end process;
end Beh;