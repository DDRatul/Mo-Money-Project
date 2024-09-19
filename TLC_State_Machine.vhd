--Author: Group 7, Chris Park, Debanjan Deb Ratul (204)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- moore state machine is created as the outputs form the machine depend on the current state 
-- as well as the input signal. this can be seen in the decoder section within this file


Entity TLC_State_Machine IS Port
(
 clk_input, sm_clken, reset, ns_in, ew_in, blink_sig : IN std_logic;
 ns_red, ns_amber, ns_green, ew_red, ew_amber, ew_green, ns_clr, ew_clr, ns_green_display, ew_green_display			: OUT std_logic;
 state_num : out std_logic_vector(3 downto 0)
 );
END ENTITY;
 

 Architecture SM of TLC_State_Machine is
 
  
 TYPE STATE_NAMES IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);   -- list all the STATE_NAMES values

 
 SIGNAL current_state, next_state	:  STATE_NAMES;     	-- signals of type STATE_NAMES


 BEGIN
 

 -------------------------------------------------------------------------------
 --State Machine: TLC
 -------------------------------------------------------------------------------

 -- REGISTER_LOGIC 
 
Register_Section: PROCESS (clk_input, sm_clken)  -- this process updates with a clock
BEGIN
	IF(rising_edge(clk_input)) THEN -- the state machine works on the rising edge
		IF (reset = '1') THEN   -- when the reset variable is pressed, it is reset
			current_state <= S0;
		ELSIF (reset = '0' AND sm_clken = '1') THEN
			current_state <= next_State;
		END IF;
	END IF;
END PROCESS;	



-- TRANSITION LOGIC 

Transition_Section: PROCESS (ns_in, ew_in, current_state) 

BEGIN
  CASE current_state IS
			when S0 => 
				if ((ns_in = '0') AND (ew_in = '1')) THEN -- when the holding registar for EW is active and NW is not, it jumps
					next_state <= S6;
				else 									-- when the holding registar for EW is active and NW is also active, it continues						
					next_state <= S1;
				end if;
				
			when S1 => 
				if ((ns_in = '0') AND (ew_in = '1')) THEN -- when the holding registar for EW is active and NW is not, it jumps
					next_state <= S6;
				else 
					next_state <= S2; -- when the holding registar for EW is active and NW is also active, it continues									
				end if;

         WHEN S2 =>		
				next_state <=S3; -- jumps to state 3
				
			WHEN S3 =>		
				next_state <=S4; -- jumps to state 4
			
			WHEN S4 =>		
				next_state <=S5;	--jumps to state 5
         
			WHEN S5 =>		
				next_state <=S6;	-- jumps to state 6
	      
			WHEN S6 =>		
				next_state <=S7;  -- jumps to state 7
				
			WHEN S7 =>		
				next_state <=S8;	-- jumps to state 8
			
			WHEN S8 => 
				if ((ns_in = '1') AND (ew_in = '0')) THEN -- when the holding registar for EW is active and NW is not, it jumps
					next_state <= S14;
				else 		                       -- when the holding registar for EW is active and NW is also active, it continues													
					next_state <= S9;
				end if;
				
			when S9 => 
				if ((ns_in = '1') AND (ew_in = '0')) THEN -- when the holding registar for EW is active and NW is not, it jump
					next_state <= S14;
				else 									-- when the holding registar for EW is active and NW is also active, it continues						
					next_state <= S10;      
				end if;	
					
			when S10 =>
				next_state <= S11; -- jumps to state 11
			
			when S11 =>
				next_state <= S12; -- jumps to state 12
				
			when S12 =>
				next_state <= S13; -- jumps to state 13
				
			when S13 =>
				next_state <= S14; -- jumps to state 14
				
			when S14 =>
				next_state <= S15; -- jumps to state 15
				
			when S15 =>
				next_state <= S0;  -- jumps to state 0

	  END CASE;
 END PROCESS;
 

-- DECODER SECTION PROCESS 
-- the decoder outputs the desired values according to the current state. This will be related to
-- the red, amber and green status of NS and EW lights, as well as the pedestrian signal and current state number

Decoder_Section: PROCESS (current_state) 

BEGIN
     CASE current_state IS
	  
         WHEN S0 =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= blink_sig; -- the green signal will be blinking when the blink_signal is inputed 
				ew_red <= '1';
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "0000";
				
        
		  WHEN S1 =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= blink_sig; -- the green signal will be blinking when the blink_signal is inputed 
				ew_red <= '1';  -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "0001";
			

         WHEN S2 =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= '1';  -- solid green signal for ns
				ew_red <= '1';  -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '1';
				ew_green_display <= '0';
				state_num <= "0010";
			
         WHEN S3 =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= '1'; -- solid green signal for ns
				ew_red <= '1'; -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '1';
				ew_green_display <= '0';
				state_num <= "0011";

         WHEN S4 =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= '1'; -- solid green signal for ns
				ew_red <= '1';    -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '1';
				ew_green_display <= '0';
				state_num <= "0100";

         WHEN S5 =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= '1'; -- solid green signal for ns
				ew_red <= '1';  -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '1';
				ew_green_display <= '0';
				state_num <= "0101";
				
         WHEN S6 =>		
				ns_red <= '0';
				ns_amber <= '1'; -- amber signal for ns/yellow
				ns_green <= '0';
				ew_red <= '1'; -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '1'; -- the clear for the NS holding register
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "0110";
				
         WHEN S7 =>		
				ns_red <= '0';
				ns_amber <= '1';  -- amber signal for ns
				ns_green <= '0';
				ew_red <= '1';  -- red signal for ew
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "0111";
				
			WHEN S8 =>
				ns_red <= '1';  -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= blink_sig;  -- the green signal will be blinking when the blink_signal is inputed for ew
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "1000";
				
			WHEN S9 =>
				ns_red <= '1'; -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= blink_sig; -- the green signal will be blinking when the blink_signal is inputed for ew
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "1001";
				
			WHEN S10 =>
				ns_red <= '1'; -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= '1'; -- solid green signal for ew
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '1';
				state_num <= "1010";
				
			WHEN S11 =>
				ns_red <= '1';  -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= '1'; -- solid green signal for ew
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '1';
				state_num <= "1011";
				
			WHEN S12 =>
				ns_red <= '1';  -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= '1'; -- green signal solid for ew
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '1';
				state_num <= "1100";
				
				
			WHEN S13 =>
				ns_red <= '1';  -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= '1'; -- solid green signal for ew
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '1';
				state_num <= "1101";
				
				
			WHEN S14 =>
				ns_red <= '1';  -- red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '1'; -- amber signal for ew
				ew_green <= '0';
				ew_clr <= '1';  -- the clear for the EW holding register
				ns_clr <= '0'; 
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "1110";
				
			WHEN S15 => 
				ns_red <= '1';  --red signal for ns
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '1';  -- amber signal for ew
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				state_num <= "1111";
				
         WHEN others =>		
				ns_red <= '0';
				ns_amber <= '0';
				ns_green <= '0';
				ew_red <= '0';
				ew_amber <= '0';
				ew_green <= '0';
				ew_clr <= '0';
				ns_clr <= '0';
				ns_green_display <= '0';
				ew_green_display <= '0';
				
	  END CASE;
 END PROCESS;

 END ARCHITECTURE SM;
