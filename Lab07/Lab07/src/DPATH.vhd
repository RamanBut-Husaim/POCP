library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DPATH is
	port(
		EN: in std_logic;
		OT: in std_logic_vector(2 downto 0);
		OP1: in std_logic_vector(7 downto 0);
		RES: out std_logic_vector(7 downto 0)
		);
end DPATH;

architecture Beh of DPATH is
	signal ACCUM: std_logic_vector(7 downto 0);
	signal res_add: std_logic_vector(7 downto 0);
	signal res_mul: std_logic_vector (7 downto 0);
	
	constant LOAD: std_logic_vector(2 downto 0) := "000";
	constant ADD: std_logic_vector(2 downto 0) := "010";
	constant MUL: std_logic_vector(2 downto 0) := "011";
Begin
	res_add <= CONV_STD_LOGIC_VECTOR(CONV_INTEGER(ACCUM) + CONV_INTEGER(OP1), 8);
	res_mul <= CONV_STD_LOGIC_VECTOR(CONV_INTEGER(ACCUM) * CONV_INTEGER(OP1), 8);
	
	REGA: process (EN, OT, OP1, res_add, res_mul)
	begin
		if rising_edge(EN) then
			case OT is
				when LOAD => ACCUM <= OP1;
				when ADD => ACCUM <= res_add;
				when MUL => ACCUM <= res_mul;
				when others => null;
			end case;
		end if;
	end process;
	
	RES <= ACCUM;
End Beh;