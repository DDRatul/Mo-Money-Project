--Author: Group 7, Chris Park, Debanjan Deb Ratul (204)


library ieee;
use ieee.std_logic_1164.all;


entity PB_inverters is port (
	rst_n				: in	std_logic; -- input reset signal
	rst				: out std_logic; -- output reset signal
 	pb_n_filtered	: in  std_logic_vector (3 downto 0);  -- input button signals
	pb					: out	std_logic_vector(3 downto 0)  -- output button signals							 
	); 
end PB_inverters;

architecture ckt of PB_inverters is

begin
rst <= NOT(rst_n);  -- inverting the reset button
pb <= NOT(pb_n_filtered); -- reversing the buttons inputs


end ckt;