library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity CTRL1 is
	port(
		CLK, RST, Start: in std_logic;
		Stop: out std_logic;
		
		-- ���
		ROM_re: out std_logic;
		ROM_adr: out std_logic_vector(2 downto 0);
		ROM_dout: in std_logic_vector(5 downto 0);
		
		-- ���
		RAM_rw: out std_logic;
		RAM_adr: out std_logic_vector(2 downto 0);
		RAM_din: out std_logic_vector(7 downto 0);
		RAM_dout: in std_logic_vector(7 downto 0);
		--datapath
		DP_op1: out std_logic_vector(7 downto 0);
		DP_ot: out std_logic_vector(2 downto 0);
		DP_en: out std_logic;
		DP_res: in std_logic_vector(7 downto 0)
		);
end CTRL1;

architecture Beh of CTRL1 is
	type states is (I, F, D, R, L, S, A, M, H);
	--I - idle -
	--F - fetch
	--D - decode
	--R - read
	--L - load
	--S - store
	--A - add
	--M - mul
	--H - halt
	signal nxt_state, cur_state: states;
	--������� ��������� ����������
	signal RI: std_logic_vector(5 downto 0);
	--������� �������� ����������
	signal IC: std_logic_vector(2 downto 0);
	--������� ���� ��������
	signal RO: std_logic_vector(2 downto 0);
	--������� ������ ������
	signal RA: std_logic_vector(2 downto 0);
	--������� ������
	signal RD: std_logic_vector(7 downto 0);
	
	constant LOAD: std_logic_vector(2 downto 0) := "000";
	constant STORE: std_logic_vector(2 downto 0) := "001";
	constant ADD: std_logic_vector(2 downto 0) := "010";
	constant MUL: std_logic_vector(2 downto 0) := "011";
	constant HALT: std_logic_vector(2 downto 0) := "100";
begin
	--���������� ������
	FSM: process(CLK, RST, nxt_state)
	begin
		if (RST = '1') then
			cur_state <= I;
		elsif rising_edge(CLK) then
			cur_state <= nxt_state;
		end if;
	end process;
	-- �������������� �����. ��������� ����. ���������
	COMB: process(cur_state, start, RO)
	begin
		case cur_state is 
			when I => 
				if (start = '1') then 
					nxt_state <= F;
				else
					nxt_state <= I;
			end if;
			when F => nxt_state <= D;
			when D => 
				if (RO = HALT) then
					nxt_state <= H;
				elsif (RO = STORE) then
					nxt_state <= S;
				else
					nxt_state <= R;
			end if;
			when R => 
				if (RO = LOAD) then 
					nxt_state <= L;
				elsif (RO = ADD) then
					nxt_state <= A;
				elsif (RO = MUL) then
					nxt_state <= M;
				else
					nxt_state <= I;
			end if;
			when L | S | A | M => nxt_state <= F;
			when H => nxt_state <= H;
			when others => nxt_state <= I;
		end case;
	end process;
	
	--��������� ������� stop
	PSTOP: process (cur_state)
	begin
		if (cur_state = H) then
			stop <= '1';
		else
			stop <= '0';
		end if;
	end process;
	
	-- ������� ����������
	PMC: process (CLK, RST, cur_state)
	begin
		if (RST = '1') then
			IC <= "000";
		elsif falling_edge(CLK) then
			if (cur_state = D) then
				IC <= IC + 1;
			end if;
		end if;
	end process;
	
	ROM_adr <= IC;
	
	--������ ������ �� ������ ROM
	PROMREAD: process (nxt_state, cur_state)
	begin
		if (nxt_state = F or cur_state = F) then
			ROM_re <= '1';
		else
			ROM_re <= '0';
		end if;
	end process;
	
	--������ ���������� �������� ���������� � ������ ��� � RI
	PROMDAT: process (RST, cur_state, ROM_dout)
	begin
		if (RST = '1') then
			RI <= "000000";
		elsif (cur_state = F) then
			RI <= ROM_dout;
		end if;
	end process;
	-- ����� ���������� ���������� RO � RA
	PRORA: process (RST, nxt_state, RI)
	begin
		if (RST = '1') then
			RO <= "000";
			RA <= "000";
		elsif (nxt_state = D) then
			RO <= RI (5 downto 3);
			RA <= RI (2 downto 0);
		end if;
	end process;
	
	RAM_adr <= RA;
	
	--����������� ������ ������/������ � RAM
	PRAMREAD: process (cur_state)
	begin
		if (cur_state = S) then
			RAM_rw <= '0';
		else
			RAM_rw <= '1';
		end if;
	end process;
	
	--������ �������� �� ������ RAM � ������� RD
	PRAMDAR: process (cur_state)
	begin
		if (cur_state = R) then
			RD <= RAM_dout;
		end if;
	end process;
	
	--�������� ��������������� �������� ������ ��������� ������ �� ������� ���� ������ RAM
	RAM_din <= DP_res;
	--�������� �������� �������� RD �� ���� ������� ��������
	DP_op1 <= RD;
	--�������� �������� �������� RO �� ������� ���� ���� ��������
	DP_ot <= RO;
	
	paddmulen: process (cur_state)
	begin
		if (cur_state = A or cur_state = M or cur_state = L) then
			DP_en <= '1';
		else
			DP_en <= '0';
		end if;
	end process;
end Beh;