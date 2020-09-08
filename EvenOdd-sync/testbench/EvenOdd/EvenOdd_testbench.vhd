library ieee;
use ieee.std_logic_1164.all;



entity EvenOdd_testbench is


end EvenOdd_testbench;



architecture EvenOdd_testbench_behave of EvenOdd_testbench is

COMPONENT EvenOdd
	PORT(

		tclk     	: in  std_logic;
	 	rclk     	: in  std_logic;
    	reset_n 	: in  std_logic;
    	data_out   : out std_logic_vector(11 downto 0);
	 	tclk_out 	: out std_logic;
    	rclk_out 	: out std_logic;
	 	data_src   : out std_logic_vector(11 downto 0);
    	data_dst   : out std_logic_vector(11 downto 0)
		
	);


END COMPONENT;

constant R_clk_period : time := 20 ns; -- 50Mhz
constant T_clk_period : time := 26 ns; --

SIGNAL R_clk,T_clk   : std_logic := '0';
SIGNAL reset : std_logic := '0';
SIGNAL tclk_out,rclk_out : std_logic :='0';

signal data_src,data_dst,data_out : std_logic_vector(11 downto 0);


BEGIN

du: EvenOdd

	port map(
		tclk=>T_clk,
		rclk=>R_clk,
		reset_n=>reset,
		data_out=>data_out,
		data_src=>data_src,
		data_dst=>data_dst,
		tclk_out=>tclk_out,
		rclk_out=>rclk_out

	);


------- CLOCKS--------------------

clock_R : PROCESS
   begin
   wait for R_clk_period/2; R_clk  <= not R_clk;
end PROCESS clock_R;

clock_T : PROCESS
   begin
   wait for T_clk_period/2; T_clk  <= not T_clk;
end PROCESS clock_T;


stimulus: process(R_clk)
begin
 if (rising_edge(R_clk))then
	if(reset = '0')then
		reset <= '1';
	end if;
 end if;
end process stimulus;  




end architecture EvenOdd_testbench_behave;