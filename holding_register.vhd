--Author: Group 7, Chris Park, Debanjan Deb Ratul (204)

library ieee;
use ieee.std_logic_1164.all;


entity holding_register is port (

			clk					: in std_logic; -- global clock signal
			reset				: in std_logic; -- asynchronous reset signal
			register_clr		: in std_logic; -- signal which is used to clear the holding registars
			din					: in std_logic; -- input into the register coming from the synchronizer
			dout				: out std_logic -- output signal which will be connected to the state machine
  );
 end holding_register;
 
 architecture circuit of holding_register is

	Signal sreg				: std_logic; -- output signal from the register which will be updated by the input for every rising edge
	
	Signal update        : std_logic; -- signal which will be updated according to a set of combinational logic

BEGIN

holding : process(clk)
	begin 
	update <=  (sreg OR din) AND NOT(register_clr); -- combinational logic derived from the lab manual
	
	if(rising_edge(clk)) then -- registar utilize positive edge flip flop
		if(reset = '1') then -- asynchronous clear the output signal based on pb(3)
			sreg <= '0';
		else
			sreg <= update; -- changing the value of the output signal
		end if;
	end if;
	
	dout <= sreg; -- final output signal being updated based on the sreg signal

	end process;


end;