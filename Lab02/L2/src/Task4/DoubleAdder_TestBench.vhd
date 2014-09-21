library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use 	std.textio.all;

entity DoubleAdder_TestBench is
end    DoubleAdder_TestBench;

architecture Beh of DoubleAdder_TestBench is
	component DoubleAdder
		Generic (n : integer := 2);
		port(
			a: in std_logic_vector(n-1 downto 0);
			b: in std_logic_vector(n-1 downto 0);
			cIn: in std_logic;
			cOut: out std_logic;
			s : out std_logic_vector(n-1 downto 0) 
			);
	end component;
	
	signal stimuli: std_logic_vector(4 downto 0) := (others => '0');
	
	signal response_struct_carry, response_beh_carry: std_logic;
	signal response_struct_sum, response_beh_sum: std_logic_vector(1 downto 0);
	
	signal adder_struct_carry, adder_beh_carry: std_logic;
	signal adder_struct_sum, adder_beh_sum: std_logic_vector(1 downto 0);
	
	signal sampled_response_struct_carry, sampled_response_beh_carry: std_logic;
	signal sampled_response_struct_sum, sampled_response_beh_sum: std_logic_vector(1 downto 0);
	
	signal error_carry: std_logic;
	signal error_sum: std_logic_vector(1 downto 0);
	
	alias firstNumber is stimuli(1 downto 0);
	alias secondNumber is stimuli (3 downto 2);
	
	constant min_time_between_events: time := 10 ns;
	constant sampling_period:         time := min_time_between_events / 2;
begin
	stimuli_generation: process
		variable buf : LINE;
	begin
		while(stimuli /= (stimuli'range => '1')) loop
			wait for min_time_between_events;
			
			stimuli <= stimuli + 1;
		end loop;
		
		write(buf, "The operation has been completed successfully.");
		writeline(output, buf);
		
		wait;
	end process;
	
	error_verification: process(error_sum)
		variable flag: std_logic;
	begin
		for i in error_sum'range loop
			if (error_sum(i) = '1') then 
				assert false report "Failure." severity failure;
			end if;
		end loop;
	end process;
	
	Adder_Struct: entity DoubleAdder(Struct) port map(
		a => firstNumber,
		b => secondNumber,
		cIn => stimuli(4),
		s => response_struct_sum,
		cOut => response_struct_carry
		);
	
	Adder_Beh:  entity DoubleAdder(Beh) port map(
		a => firstNumber,
		b => secondNumber,
		cIn => stimuli(4),
		s => response_beh_sum,
		cOut => response_beh_carry
		);
	
	adder_struct_carry <= response_struct_carry;
	adder_beh_carry  <= response_beh_carry;	
	adder_struct_sum <= response_struct_sum;
	adder_beh_sum  <= response_beh_sum;
	
	sampled_response_struct_sum <= response_struct_sum after sampling_period;
	sampled_response_beh_sum  <= response_beh_sum  after sampling_period;
	sampled_response_struct_carry <= response_struct_carry after sampling_period;
	sampled_response_beh_carry  <= response_beh_carry  after sampling_period;
	
	error_sum <= sampled_response_struct_sum xor sampled_response_beh_sum;
	error_carry <= sampled_response_struct_carry xor sampled_response_beh_carry;
	
	assert error_carry /= '1' report "The device doesn't work as expected." severity failure;
	--assert error_sum = (error_sum'range => '0') report "The device doesn't work as expected." severity failure;
end Beh;
