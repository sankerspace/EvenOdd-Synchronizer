LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;   


entity estimatorv2 is
 generic
  ( -- A=S+1 (S is delay of synchronizers, including samplinl)
	 A : Integer range 1 to 50 := 4 ;  -- number of Flip Flops 
     B : integer range 1 to 50 := 10  -- number of bits  
  );
port (
	f 		:in std_logic_vector(B downto 0); --B+1 bits
	d 		:in std_logic_vector(B downto 0);--B+1 bits
	dete	:in std_logic;
	deto	:in std_logic;
	res_n :in std_logic;
	rclk	:in std_logic;
	pl		:out std_logic_vector(B downto 0);--B+1 bits
	pu		:out std_logic_vector(B downto 0)--B+1 bits
	
	
	);

end entity estimatorv2;


--transmitter and receiver with the same frequency
--f=2^(B),B=10,"10000000000"



architecture estimatorv2_behave of estimatorv2 is
constant one					:signed(2*B downto 0):=(0=>'1',others=>'0');
signal d_s						:std_logic_vector(2*B downto 0):=(others=>'0');
signal det 						:std_logic;
signal pu_s,pl_s				:std_logic_vector(B downto 0):= (others=>'0');
signal np_lu_g,f_s				:std_logic_vector(2*B downto 0):= (others=>'0'); --MSB for signed Bit
signal pl_fa,pu_fa				:signed(2*B downto 0):= (others=>'0');			 --MSB for signed Bit
signal pu_det,pl_det,pu_no,pl_no:signed(2*B downto 0):= (others=>'0');	
begin

 det <= dete or deto;

 d_s(B downto 0)<=d;
 --d_invert <= to_signed((to_integer(signed(d))*(-1)),d_invert'length);
 --d_invert <= to_unsigned(1,d_invert'length)-signed(d);
 np_lu_g<= (B => dete, others => '0'); -- VALUE 0 OR 1024
	
 pu_fa  <= to_signed( to_integer((signed(f_s)) + 1)*A, pu_fa'length); -- [(f=1024) + 1] * (A=4)  => 1025*4 = 4100 = 1 0000 0000 0100   
	
 pl_fa  <= to_signed( to_integer((signed(f_s)) - 1)*A, pl_fa'length); -- [(f=1024) - 1] * (A=4)	 => 1023*4 = 4092 = 1 1111 1111 1100

 pu_det <=signed(np_lu_g)+signed(d_s)+pu_fa; -- (1024,0) + 512 + 4100 = (5636,4612) = 1 0110 0000 0100 , 1 0010 0000 0100

 pl_det <=signed(np_lu_g)-signed(d_s)+pl_fa; -- (1024,0) - 512 + 4092 = (4604,3580) = 1 0001 1111 1100 , 1101 1111 1100

 pu_no  <=signed(pu_s)+ signed(f_s) + one; 	-- old + 1025

 pl_no  <=signed(pl_s)+ signed(f_s) - one; 	-- old + 1023
		
 f_s(B downto 0) <= f;

 pu<=pu_s;

 pl<=pl_s;

 sync:process (rclk,res_n)
 begin
	if(res_n='0')then
		pl_s<=(others => '0');
		pu_s<=(others => '0');
	elsif rising_edge(rclk) then
		if (det='1') then
			pu_s<=std_logic_vector(pu_det(B downto 0));-- "110 0000 0100","010 0000 0100" =  1540,516
			pl_s<=std_logic_vector(pl_det(B downto 0));-- "001 1111 1100","101 1111 1100101 1111 110" =  508,1532
		elsif(det='0')then
			pu_s<=std_logic_vector(pu_no(B downto 0)); -- 516+1025="1541" , 1541+1025=2566mod2048="518", 518+1025="1543",1543+1025=2568mod2048="520",1545,522,....
													   -- 1540+1025=2565mod2048="517", 517+1025="1542",1542+1025=2567mod2048="519"
			pl_s<=std_logic_vector(pl_no(B downto 0)); -- 508+1023="1531",1531+1023=2554mod2048="506",506+1023="1529",1529+1023=2552mod2048="504","1527","502"...
		end if;
	end if;
 
 end process sync;

end architecture estimatorv2_behave;
