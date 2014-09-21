library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use 	std.textio.all;

entity MegaMux_TestBench is
end    MegaMux_TestBench;

architecture Beh of MegaMux_TestBench is
    component MegaMux
        port(
            a, b: in  std_logic;
            a1, b1: in  std_logic;
            s: in  std_logic;
            z, z1: out std_logic
            );
    end component;
    
    signal stimuli: std_logic_vector(4 downto 0) := (others => '0');
    
    signal response_struct, response_struct_z1, response_beh, response_beh_z1: std_logic;
    
    signal Mux_Struct_z, Mux_Struct_z1, Mux_Beh_z, Mux_Beh_z1: std_logic;
    
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
	
    Mux_Struct: entity MegaMux(Struct) port map(
		a => stimuli (4),
		b => stimuli (3),
        a1 => stimuli(2),
        b1 => stimuli(1),
        s => stimuli(0),
        z => response_struct,
		z1 => response_struct_z1
        );
    
    Mux_Beh:  entity MegaMux(Beh) port map(
        a => stimuli (4),
		b => stimuli (3),
        a1 => stimuli(2),
        b1 => stimuli(1),
        s => stimuli(0),
        z => response_beh,
		z1 => response_beh_z1
        );
		
    Mux_Struct_z <= response_struct;
    Mux_Beh_z  <= response_beh;	
	Mux_Struct_z1 <= response_struct_z1;
    Mux_Beh_z1  <= response_beh_z1;
    
    sampled_response_struct <= response_struct after sampling_period;
    sampled_response_beh  <= response_beh  after sampling_period;
	sampled_response_struct_z1 <= response_struct_z1 after sampling_period;
    sampled_response_beh_z1  <= response_beh_z1  after sampling_period;
    
    error <= (sampled_response_struct xor sampled_response_beh) and (sampled_response_struct_z1 xor sampled_response_beh_z1);
    
    assert error /= '1' report "The device doesn't work as expected." severity failure;
end Beh;
