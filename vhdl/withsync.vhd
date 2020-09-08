library ieee;
use ieee.std_logic_1164.all;


entity withsync is
  port (
    clk_src     : in  std_logic;
    clk_dst     : in  std_logic;
    reset_n     : in  std_logic;
    data_src    : out std_logic_vector(11 downto 0);
    req         : out std_logic;
    data_dst    : out std_logic_vector(11 downto 0);
    ack         : out std_logic;
    clk_src_out : out std_logic;
    clk_dst_out : out std_logic;
	 reset_o		 : out std_logic
    );
end entity withsync;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity src is
  port (
    clk     : in  std_logic;
    reset_n : in  std_logic;
    data    : out std_logic_vector(11 downto 0);
	 ack     : in std_logic;
    req     : out std_logic
    );
end entity src;

library ieee;
use ieee.std_logic_1164.all;

entity dst is
  port (
    clk      : in  std_logic;
    reset_n  : in  std_logic;
    data     : in  std_logic_vector(11 downto 0);
    req      : in  std_logic;
	 ack     : out std_logic;
    data_out : out std_logic_vector(11 downto 0)
    );
end entity dst;



architecture src_arch of src is
  signal data_tgl            : std_logic_vector(7 downto 0) :="10101010";
  attribute keep             : boolean;
  attribute keep of data_tgl : signal is true;
  signal data_cnt            : unsigned(3 downto 0);
  signal reqreg              : std_logic;
  signal reset_sync          : std_logic;
  
begin
  rst : process(clk, reset_n)
  begin
    if reset_n = '0' then
      reset_sync <= '0';
    elsif rising_edge(clk) then
      reset_sync <= '1';
    end if;
  end process rst;

  sync : process(clk, reset_sync)
  begin
    if reset_sync = '0' then
      data_tgl <= "10101010";--0xAA
      data_cnt <= to_unsigned(0, data_cnt'length);
      reqreg   <= '0';
    elsif rising_edge(clk) then
		if reqreg = ack then
			data_tgl <= not data_tgl;
			data_cnt <= data_cnt + 1;
			reqreg   <= not reqreg;
		end if;
    end if;
  end process sync;

  data <= data_tgl & std_logic_vector(data_cnt); --concatenation of vectors
  req  <= reqreg;

 
 end architecture src_arch;

architecture dst_arch of dst is
  signal reset_sync : std_logic;
  signal datareg    : std_logic_vector(data'range):=(others => '0');
  signal ackreg     : std_logic;
begin
  rst : process(clk, reset_n)
  begin
    if reset_n = '0' then
      reset_sync <= '0';
    elsif rising_edge(clk) then
      reset_sync <= '1';
    end if;
  end process rst;

  reg : process(clk, reset_sync)
  begin
    if reset_sync = '0' then
      datareg <= (others => '0');
		ackreg	<= '0';
    elsif rising_edge(clk) then
	   if req /= ackreg then
        datareg <= data;
		  ackreg	 <= not ackreg;
      end if;
    end if;
  end process reg;

  data_out <= datareg;
  ack <= ackreg;
end architecture dst_arch;

architecture withsync_arch of withsync is
  signal s_data : std_logic_vector(11 downto 0);
  signal s_req  : std_logic;
  signal s_ack  : std_logic;
  signal s_req_sync  : std_logic;
  signal s_ack_sync  : std_logic;
begin
  src_inst : entity work.src
    port map (--The port map specifies the connection of the ports of each component instance
			  --to signals within the enclosing architecture body.
    -- src   =>  top
      clk     => clk_src,
      reset_n => reset_n,
      data    => s_data,
      req     => s_req,
		ack	  => s_ack_sync
      );

  dst_inst : entity work.dst
    port map (
      clk      => clk_dst,
      reset_n  => reset_n,
      data     => s_data,
      req      => s_req_sync,
		ack	  => s_ack,
      data_out => data_dst
      );

 
		
  clk_src_out <= clk_src;
  clk_dst_out <= clk_dst;
  data_src    <= s_data;
  req         <= s_req;
  ack         <= s_ack;
  reset_o	  <= reset_n;
 
 
 
 -- SYNCHRONIZER FOR SIGNAL ACK AND REQ only 
 sync_ack : entity work.sync
	generic map
	(
		SYNC_STAGES =>3,
		RESET_VALUE =>'0'
	)
	port map(
		clk		=>	clk_src,
		res_n		=>	reset_n,
		data_in	=>	s_ack,
		data_out	=>	s_ack_sync
  );
 
 sync_req : entity work.sync
 	generic map
	(
		SYNC_STAGES =>3,
		RESET_VALUE =>'0'
	)
	port map(
		clk		=>	clk_dst,
		res_n		=>	reset_n,
		data_in	=>	s_req,
		data_out	=>	s_req_sync
  );
 
end architecture withsync_arch;
