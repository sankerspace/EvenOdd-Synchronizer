LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity EvenOdd is
	port (
    tclk     	: in  std_logic;
	 rclk     	: in  std_logic;
    reset_n 	: in  std_logic;
    data_out   : out std_logic_vector(11 downto 0);
	 tclk_out 	: out std_logic;
    rclk_out 	: out std_logic;
	 data_src   : out std_logic_vector(11 downto 0);
    data_dst   : out std_logic_vector(11 downto 0)
	 --ack     : in std_logic;
    --req     : out std_logic
    );

end entity EvenOdd;



architecture behave of EvenOdd is
signal s_data:std_logic_vector(11 downto 0);
signal s_data_sync:std_logic_vector(11 downto 0);

begin

s : entity work.src
	port map(
		clk=>tclk,
		reset_n=>reset_n,		
		data=>s_data
	);

d : entity work.dst
	port map(
		clk=>rclk,					
		reset_n=>reset_n,
		data=>s_data_sync,
		data_out=>data_out
	);

Sync: entity work.evenoddsync
	generic map( 
		D_g => 12		-- Data width
	)
	port map(
		rclk=>rclk,  
		tclk=>tclk,  
		res_n=>reset_n,
		tdata=>s_data,
		rdata=>s_data_sync
	);	
		
tclk_out <= tclk;
rclk_out <= rclk;
data_src <= s_data;
data_dst <= s_data_sync;

end architecture behave;






