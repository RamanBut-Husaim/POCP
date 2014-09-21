library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use 	std.textio.all;

entity CustomMux_TestBench is
end    CustomMux_TestBench;

architecture Beh of CustomMux_TestBench is
    component CustomMux
        port(
            a1: in  std_logic;
            b1: in  std_logic;
            s1: in  std_logic;
            z1: out std_logic
            );
    end component;
    
    signal stimuli: std_logic_vector(2 downto 0) := (others => '0');
    
    signal response_struct, response_beh: std_logic;
    
    signal Mux_Struct_z, Mux_Beh_z: std_logic;
    
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
	
    Mux_Struct: entity CustomMux(Struct) port map(
        a1 => stimuli(2),
        b1 => stimuli(1),
        s1 => stimuli(0),
        z1 => response_struct
        );
    
    Mux_Beh:  entity CustomMux(Beh) port map(
        a1 => stimuli(2),
        b1 => stimuli(1),
        s1 => stimuli(0),
        z1 => response_beh
        );
		
    Mux_Struct_z <= response_struct;
    Mux_Beh_z  <= response_beh;
    
    sampled_response_struct <= response_struct after sampling_period;
    sampled_response_beh  <= response_beh  after sampling_period;
    
    error <= sampled_response_struct xor sampled_response_beh;
    
    assert error /= '1' report "The device doesn't work as expected." severity failure;
end Beh;
