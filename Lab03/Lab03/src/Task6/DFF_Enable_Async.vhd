LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
entity DFF_Enable_Async IS PORT (
		Clock: IN std_logic;
		Enable: IN std_logic;
		Set: IN std_logic;
		Clear: IN std_logic;
		D: IN std_logic;
		Q: OUT std_logic);
end DFF_Enable_Async;
architecture Behavioral OF DFF_Enable_Async IS
begin
	process(Clock,Set,Clear)
	begin
		if (Set = '1') then
			Q <= '1';
		elsif (Clear = '1') then
			Q <= '0';
		elsif (Clock'event and Clock = '1') then
			if Enable = '1' then
				Q <= D;
			end if;
		end if;
	end process;
end Behavioral;