LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;   


entity estimator is
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

end entity estimator;

/*
transmitter and receiver with the same frequency
f=2^(B),B=10,"10000000000"
*/


architecture estimator_behave of estimator is

signal det : std_logic;
signal FA_l,FA_u,pl_f,pu_f  : integer range -4096 to 4096;
signal npl,npu,np_lu_g	:std_logic_vector(B downto 0);


begin

 det <= dete or deto;
 

 mux: process(det)
 begin
	if (det = '1') then
		npl <= std_logic_vector( signed(np_lu_g) + to_signed(FA_l,npl'length));
		npu <= std_logic_vector(signed(np_lu_g) + to_signed(FA_u,npu'length));
	elsif (det = '0') then
		npl <= (std_logic_vector(to_signed(pl_f,npl'length)));
		npu <= (std_logic_vector(to_signed(pu_f,npu'length)));
	end if;
 end process mux;
 
 np_lu_g<= (B => dete, others => '0');
 FA_l <= (((to_integer(signed(f)) - 1) * A) - to_integer(signed(d))) mod 2048 ; -- for pl and even detection
 FA_u <= (((to_integer(signed(f)) + 1) * A) - to_integer(signed(d))) mod 2048 ;-- for pu and even detection
 pl_f <=	(to_integer(signed(npl)) + to_integer(signed(f)) - 1) mod 2048; --for 
 pu_f <=	(to_integer(signed(npu)) + to_integer(signed(f)) + 1) mod 2048;
 
  --register for pl lower phase estimate
 dff_pl_inst: work.d_ff_v
	generic map(
		SIZE_VECTOR => B+1
	)
	port map(
		clk => rclk,
		res_n => res_n,
		en => '1',
		d => npl,
		q => pl
	);
 --register for pu lower phase estimate
 dff_pu_inst: work.d_ff_v
	generic map(
		SIZE_VECTOR => B+1
	)
	port map(
		clk => rclk,
		res_n => res_n,
		en => '1',
		d => npu,
		q => pu
	); 
 
end architecture estimator_behave;
