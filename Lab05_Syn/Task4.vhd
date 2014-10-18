-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Lab05
-- Author      : Shadowmaker
-- Company     : Home
--
-------------------------------------------------------------------------------
--
-- File        : E:\Embedded\Projects\POCP\Lab05\Lab05\compile\Task4.vhd
-- Generated   : 10/18/14 16:15:12
-- From        : E:\Embedded\Projects\POCP\Lab05\Lab05\src\Task4.asf
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

entity Task4 is 
	port (
		CLK: in STD_LOGIC;
		IP: in STD_LOGIC_VECTOR (3 downto 0);
		RST: in STD_LOGIC;
		OP: out STD_LOGIC_VECTOR (1 downto 0));
end Task4;

architecture Beh of Task4 is

-- SYMBOLIC ENCODED state machine: state
type state_type is (
    S0, S1, S2, S3, S4
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
	OP <= "00";
	case state is
		when S0 =>
			OP<="00";
			if IP="0011" then	
				NextState_state <= S1;
			else
				NextState_state <= S4;
			end if;
		when S1 =>
			OP<="01";
		when S2 =>
			OP<="10";
			if IP="1100" then	
				NextState_state <= S1;
			elsif IP="1111" then	
				NextState_state <= S4;
			end if;
		when S3 =>
			OP<="00";
			if IP="0000" then	
				NextState_state <= S2;
			end if;
		when S4 =>
			OP<="11";
			if IP="1101" then	
				NextState_state <= S3;
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
		if RST='1' then	
			state <= S0;
		else
			state <= NextState_state;
		end if;
	end if;
end process;

end Beh;
