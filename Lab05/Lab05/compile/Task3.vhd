-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Lab05
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : I:\Embedded\_Projects\POCP\Lab05\Lab05\compile\Task3.vhd
-- Generated   : 10/18/14 14:35:36
-- From        : I:\Embedded\_Projects\POCP\Lab05\Lab05\src\Task3.asf
-- By          : FSM2VHDL ver. 5.0.7.2
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Task3 is 
	port (
		CLK: in STD_LOGIC;
		CLR: in STD_LOGIC;
		IP: in STD_LOGIC_VECTOR (3 downto 0);
		OP: out STD_LOGIC_VECTOR (1 downto 0));
end Task3;

architecture Beh of Task3 is

-- SYMBOLIC ENCODED state machine: state
type state_type is (
    S0, S1, S3, S4, S2
);
-- attribute enum_encoding of state_type: type is ... -- enum_encoding attribute is not supported for symbolic encoding

signal state, NextState_state: state_type;

-- Declarations of pre-registered internal signals

begin


----------------------------------------------------------------------
-- Machine: state
----------------------------------------------------------------------
------------------------------------
-- Next State Logic (combinatorial)
------------------------------------
state_NextState: process (IP, state)
begin
	NextState_state <= state;
	-- Set default values for outputs and signals
	OP <= "01";
	case state is
		when S0 =>
			OP<="01";
			if IP="0011" then
				NextState_state <= S1;
			end if;
		when S1 =>
			OP<="01";
			if IP="1111" then
				NextState_state <= S4;
			end if;
		when S3 =>
			OP<="00";
			if IP="0000" then
				NextState_state <= S2;
			end if;
		when S4 =>
			OP<="11";
			if IP="1011" then
				NextState_state <= S3;
			end if;
		when S2 =>
			OP<="00";
			if IP="1100" then
				NextState_state <= S1;
			end if;
--vhdl_cover_off
		when others =>
			null;
--vhdl_cover_on
	end case;
end process;

------------------------------------
-- Current State Logic (sequential)
------------------------------------
state_CurrentState: process (CLK)
begin
	if CLK'event and CLK = '1' then
		state <= NextState_state;
	end if;
end process;

end Beh;
