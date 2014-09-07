-------------------------------------------------------------------------------
--
-- Title       : mux
-- Design      : Mux_Element
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : I:\Embedded\_Projects\Labs\Lab01\Mux_Element\src\mux.vhd
-- Generated   : Sun Sep  7 16:38:39 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {mux} architecture {beh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux is
	port(        -- Ports description
		A,B,S: in std_logic;    -- A and B are logical inputs
		-- S is the control input signal
		Z: out std_logic      -- Z is a logical output
		);
end mux;

--}} End of automatically maintained section

architecture beh of mux is
begin
	Z<=A when S='0' else B;
end beh;
