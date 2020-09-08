LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


entity detector is
port (
		tclk,rclk,res_n,sel : in std_logic;
		deto,dete,evenm: out std_logic
		);

end entity detector;



architecture detector_behave of detector is
signal toogle,even_s,evenm_s : std_logic :='0';
signal td_f3,td_f2,de,dl,dls,des :std_logic :='0';

begin

	ToogleFF: process(tclk,res_n)
	begin
		if (res_n = '0') then
			toogle <= '0';
		elsif rising_edge(tclk) then
			toogle <= not toogle;
		end if;
	end process ToogleFF;


	F1 : entity work.t_ff
	port map(
		Clock=>tclk,
		Reset=>res_n,
		En=>'1',
		T=>toogle,
		Q=>even_s
	);

	
	mux : process(even_s,sel)
	begin
		if sel = '0' then
			evenm_s <= even_s;
		elsif sel = '1' then
			evenm_s <= '0';
		end if;
	end process mux;

	TD1:entity work.delay_line
	port map(
		a => rclk,
		b => td_f2
	);
	
	
	F2 : entity work.d_ff
	port map(
		clk=>td_f2,
		res_n=>res_n,
		en => '1',
		d=>evenm_s,
		q=>dl
	);
	
	TD2:entity work.delay_line
	port map(
		a => evenm_s,
		b => td_f3
	);
	
	
	F3 : entity work.d_ff
	port map(
		clk=>rclk,
		res_n=>res_n,
		en => '1',
		d=>td_f3,
		q=>de
	);
	
	
	SYNC1:entity work.sync
	generic map
	(
		SYNC_STAGES =>2,
		RESET_VALUE =>'0'
	)
	port map(
		clk => rclk,
		res_n => res_n,
		data_in => dl,
		data_out=> dls
	);
	
	SYNC2:entity work.sync
	generic map
	(
		SYNC_STAGES =>2,
		RESET_VALUE =>'0'
	)
	port map(
		clk => rclk,
		res_n => res_n,
		data_in => de,
		data_out=> des
	);
	

	deto <= dls and not des;
	dete <= des and not dls;
	evenm <=evenm_s;
end architecture detector_behave;


