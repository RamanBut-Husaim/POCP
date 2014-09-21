library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use 	std.textio.all;

entity var2schema_TestBench is
end    var2schema_TestBench;

architecture Beh of var2schema_TestBench is
	component var2schema
		port(
			x, y, z: in  std_logic;
			f: out std_logic
			);
	end component;
	
	signal stimuli: std_logic_vector(2 downto 0) := (others => '0');
	
	signal response_struct, response_beh: std_logic;
	
	signal elem_Struct_z, elem_Beh_z: std_logic;
	
	signal sampled_response_struct, sampled_response_beh: std_logic;
	
	signal error: std_logic;
	
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
	
	Elem_Struct: entity var2schema(Struct) port map(
		x => stimuli(2),
		y => stimuli(1),
		z => stimuli(0),
		f => response_struct
		);
	
	Mux_Beh:  entity var2Schema(Beh) port map(
		x => stimuli(2),
		y => stimuli(1),
		z => stimuli(0),
		f => response_beh
		);
	
	elem_Struct_z <= response_struct;
	elem_Beh_z  <= response_beh;
	
	sampled_response_struct <= response_struct after sampling_period;
	sampled_response_beh  <= response_beh  after sampling_period;
	
	error <= sampled_response_struct xor sampled_response_beh;
	
	assert error /= '1' report "The device doesn't work as expected." severity failure;
end Beh;
