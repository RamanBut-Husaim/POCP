library ieee;
use ieee.std_logic_1164.all;

entity ShiftReg is
	generic (N: integer:= 3);
	port(
		Din, EN, CLK, CLR: in std_logic;
		Dout: out std_logic_vector(N-1 downto 0)
		);
end ShiftReg;				  

architecture Beh of ShiftReg is	 
	signal outS: std_logic_vector(N-1 downto 0);
begin		  
	process(CLR, CLK) 
	begin  		
		if (CLR = '1') then
			outS <= (others => '0');	  
		elsif (rising_edge(CLK)) then
			if (EN = '1') then		  
				outS(0) <= Din;
				for i in 1 to N-1 loop 
					outS(i) <= outS(i-1); 
				end loop; 
			end if;
		end if;
	end process; 
	Dout <= outS; 
end Beh;

architecture Struct of ShiftReg is
	component DFF_Enable_Async is
		port (
			Clock: in std_logic;
			Enable: in std_logic;
			Clear: in std_logic;
			D: in std_logic;
			Q: out std_logic);
	end component;	  					   
	signal outS: std_logic_vector(N-1 downto 0);
begin			   
	U_0: entity DFF_Enable_Async 
	port map(CLK, EN, CLR, outS(0));
	SCH: for J in 1 to N-1 generate			
		U_J: entity DFF_Enable_Async 
		port map (CLK,EN,CLR,outS(J-1),outS(J));
	end generate;				 
	Dout <= outS;
end Struct;