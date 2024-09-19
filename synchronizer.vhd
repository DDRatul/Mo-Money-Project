--Author: Group 7, Chris Park, Debanjan Deb Ratul (204)


library ieee;
use ieee.std_logic_1164.all;


entity synchronizer is port (

			clk			: in std_logic; -- global clock signal
			reset		: in std_logic; -- asynchronous reset signal linked with pb(3)
			din			: in std_logic; -- external input
			dout		: out std_logic  -- output signal from the synchronizer
  );
end synchronizer;
 
 
architecture circuit of synchronizer is

	Signal sreg				: std_logic_vector(1 downto 0); -- 2 bit signal with first bit assgined to the output of first register
	                                                       -- and second bit assgined to the output of second register

BEGIN

synchronizing : process(clk) 
	begin 
		
	if (rising_edge(clk)) then  -- register is based on the global clock as we are using a positive edge triggered flip flop
		sreg(1) <= sreg(0);   -- changing the output of the second register
		
		if(reset = '1') then -- in the case which reset is applied, first register changes to 0
			sreg(0) <= '0';
		else
			sreg(0) <= din; -- changing the value of the first register
		end if;
	end if;
	
	dout <= sreg(1);  -- output synchronized from the second register
	end process;


end;