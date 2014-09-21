library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use 	std.textio.all;

entity FullAdder_TestBench is
end    FullAdder_TestBench;

architecture Beh of FullAdder_TestBench is
    component FullAdder
        port(
            a, b, cIn: in std_logic;
			s, cOut: out std_logic
            );
    end component;
    
    signal stimuli: std_logic_vector(2 downto 0) := (others => '0');
    
    signal response_struct, response_struct_z1, response_beh, response_beh_z1: std_logic;
    
    signal Adder_Struct_z, Adder_Struct_z1, Adder_Beh_z, Adder_Beh_z1: std_logic;
    
    signal sampled_response_struct, sampled_response_struct_z1, sampled_response_beh, sampled_response_beh_z1: std_logic;
    
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
	
    Adder_Struct: entity FullAdder(Struct) port map(
		a => stimuli (2),
		b => stimuli (1),
        cIn => stimuli(0),
        s => response_struct,
		cOut => response_struct_z1
        );
    
    Adder_Beh:  entity FullAdder(Beh) port map(
        a => stimuli (2),
		b => stimuli (1),
        cIn => stimuli(0),
        s => response_beh,
		cOut => response_beh_z1
        );
		
    Adder_Struct_z <= response_struct;
    Adder_Beh_z  <= response_beh;	
	Adder_Struct_z1 <= response_struct_z1;
    Adder_Beh_z1  <= response_beh_z1;
    
    sampled_response_struct <= response_struct after sampling_period;
    sampled_response_beh  <= response_beh  after sampling_period;
	sampled_response_struct_z1 <= response_struct_z1 after sampling_period;
    sampled_response_beh_z1  <= response_beh_z1  after sampling_period;
    
    error <= (sampled_response_struct xor sampled_response_beh) or (sampled_response_struct_z1 xor sampled_response_beh_z1);
    
    assert error /= '1' report "The device doesn't work as expected." severity failure;
end Beh;
