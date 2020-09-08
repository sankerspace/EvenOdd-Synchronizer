LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all; 

entity evenoddsync is
	generic( 
		D_g	  :integer range 1 to 50    := 12; 		-- Data width
		D_ph_g :integer range 1 to 100  := 50;		--d=t_d/t_tcy=8ns/16,67ns=0,48~0,5
		B_ph_g : integer range 1 to 50   := 10;  	-- number of nominal bits frequency and phase - overflow bit added additional
															--  ( Selector,PhaseDetector,PhaseEstimator )
		T_to_g : integer range 1 to 50   := 16; 	--number of bits COUNTER ( Selector )- FSM Selector- Timeout
		X_ph_g : integer range 1 to 100  := 20; 	-- KEEP OUT REGION IN PERCENT  ( Selector )
		K_ph_g : integer range 1 to 100  := 50; 	--  PHASE BOUND IN PERCENT  ( Selector )
		A_ph_g:  integer range 1 to 100  := 4
		
  );
	port(
		rclk    :in std_logic;
		tclk	:in std_logic;
		res_n	:in std_logic;
		tdata   :in std_logic_vector(D_g downto 1);
		rdata   :out std_logic_vector(D_g downto 1);
		sel,evenm		:out std_logic
        
	);

end entity evenoddsync ;


architecture evenoddsync_behave of evenoddsync is
constant V 									:std_logic_vector(B_ph_g downto 0) 	:= ( B_ph_g => '1', others => '0');
constant	D_ph_int						:integer							:=(to_integer(unsigned(V))*D_ph_g)/100;	-- keep of attention of integer
signal emux,omux,mo							:std_logic_vector(D_g downto 1);
signal even_s,not_even_s,dete_s,deto_s,sel_s,tctr_s,start_s:std_logic := '0';
signal pl_ph,pu_ph							:std_logic_vector(B_ph_g downto 0)	:=(others=>'0');
-- relative frequency fixed without a frequency estimator
signal f_ph									:std_logic_vector(B_ph_g downto 0)	:=(B_ph_g=>'1',others=>'0'); -- Relative Frequency Fixed 
-- detection interval fixed without Circuit to measure detection interval
signal d_ph									:std_logic_vector(B_ph_g downto 0)	:= std_logic_vector(to_unsigned(D_ph_int,B_ph_g+1));	  ------------- Test 512

begin

--circumvent the frequency estimator
tctr_s <= '1' when start_s = '1' else '0';
not_even_s<=not even_s;

mux : process(sel_s,emux,omux)
	begin
		if sel_s = '0' then
			mo<=emux;
		elsif sel_s = '1' then
			mo<=omux;
		end if;
	end process mux;


E : entity work.d_ff_v
	generic map(
		SIZE_VECTOR => D_g
	)
	port map(
		clk=>tclk,
		res_n=>res_n,
		en => even_s,
		d=>tdata,
		q=>emux
	);
	
O : entity work.d_ff_v
	generic map(
		SIZE_VECTOR => D_g
	)
	port map(
		clk=>tclk,
		res_n=>res_n,
		en => not_even_s,
		d=>tdata,
		q=>omux
	);

Data : entity work.d_ff_v
	generic map(
		SIZE_VECTOR => D_g
	)
	port map(
		clk=>rclk,
		res_n=>res_n,
		en => '1',
		d=>mo,
		q=>rdata
	);	
--Phase Detector	
Detect : entity work.detector
	
	port map(
		tclk=>tclk,
		rclk=>rclk,
		res_n=>res_n,
		sel=>'0', -- mux select
		deto=>deto_s,
		dete=>dete_s,
		evenm=>even_s
	);	
--Phase Estimate
Estimate: entity work.estimatorv2
	generic map(
		A => A_ph_g,
		B => B_ph_g
	)
	port map(
		rclk=>rclk,
		res_n=>res_n,
		f => f_ph ,
		d=> d_ph,
		dete=> dete_s,
		deto=> deto_s,
		pl=> pl_ph,
		pu=> pu_ph

	);
--Selector
Selecto: entity work.Selector
	generic map(
		B_ph=>B_ph_g,
		T_to=>T_to_g,
		X_ph=>X_ph_g,
		K_ph=>K_ph_g
	)
	port map(
		clk=>rclk,
		res_n=>res_n,
		evenm=>even_s,
		tctr=>tctr_s,
		deto=>deto_s,
		dete=>dete_s,
		pl=> pl_ph,
		pu=> pu_ph,
		st=> start_s,
		sel=>sel_s
	);




end architecture evenoddsync_behave;