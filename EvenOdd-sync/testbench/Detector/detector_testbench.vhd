
library ieee;
use ieee.std_logic_1164.all;


entity test_detector is
   -- PORT ( count : BUFFER bit_vector(8 downto 1));
end;


-------------------------------------------------------


architecture test_detector_behave of test_detector is

COMPONENT detector
	PORT(
		tclk,rclk,res_n,sel : in std_logic;
		deto,dete,evenm: out std_logic
	);


END COMPONENT;

 constant R_clk_period : time := 20 ns; -- 50Mhz
 constant T_clk_period : time := 16 ns; --

SIGNAL R_clk,T_clk   : std_logic := '0';
SIGNAL reset : std_logic := '1';
SIGNAL SEL : std_logic :='0';
SIGNAL test_deto,test_dete,test_evenm: std_logic;
begin
--------- DUT ---------------
dut: detector
	port map(
	tclk=>T_clk,
	rclk=>R_clk,
	res_n=>reset,
	sel=>SEL,
	deto=>test_deto,
	dete=>test_dete,
	evenm=>test_evenm
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

SEL <= '0';
end architecture test_detector_behave;

