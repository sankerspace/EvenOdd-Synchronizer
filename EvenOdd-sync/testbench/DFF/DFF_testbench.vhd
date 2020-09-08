
library ieee;
use ieee.std_logic_1164.all;


entity test_TFF is
   -- PORT ( count : BUFFER bit_vector(8 downto 1));
end;


-------------------------------------------------------



architecture test_TFF_behave of test_TFF is

COMPONENT T_FF
	PORT(
		T: in std_logic;
		Reset: in std_logic;	
		Clock: in std_logic;
		Q: out std_logic
	);


END COMPONENT;

constant clk_period : time := 20 ns; -- 50Mhz
constant input_period : time := 100 ns; -- 10Mhz
SIGNAL clk   : std_logic := '0';
SIGNAL reset : std_logic := '0';


SIGNAL input,output: std_logic :='0';
begin
--------- DUT ---------------
dut: t_ff
	port map(
		Clock => clk,
		Reset => reset,
		T => input,
		Q => output		
	);

------- CLOCKS--------------------

clock : PROCESS
   begin
   wait for clk_period/2; clk  <= not clk;
end PROCESS clock;


stimulus: process is
begin
	if(reset = '0')then
		reset <= '1';
	end if;
  wait for input_period/2; input  <= not input;
end process stimulus;  


end architecture  test_TFF_behave;
