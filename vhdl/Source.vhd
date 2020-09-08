library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity src is

  port (
    clk     : in  std_logic;
    reset_n : in  std_logic;
    data    : out std_logic_vector(11 downto 0)
	 --ack     : in std_logic;
    --req     : out std_logic
    );
end entity src;


architecture src_arch of src is
  signal data_tgl            : std_logic_vector(7 downto 0);
  attribute keep             : boolean;
  attribute keep of data_tgl : signal is true;
  signal data_cnt            : unsigned(3 downto 0);
  --signal reqreg              : std_logic;
  signal reset_sync          : std_logic;
  
begin
  rst : process(clk, reset_n)
  begin
    if reset_n = '0' then
      reset_sync <= '0';
    elsif rising_edge(clk) then
      --reset_sync <= '1' & reset_sync(1);
		reset_sync <= '1';
    end if;
  end process rst;

  sync : process(clk, reset_sync)
  begin
    if reset_sync = '0' then
      data_tgl <= "10101010";--0xAA
      data_cnt <= to_unsigned(0, data_cnt'length);
      --reqreg   <= '0';
    elsif rising_edge(clk) then
		--if reqreg = ack then
		data_tgl <= not data_tgl;
		data_cnt <= data_cnt + 1;
			--reqreg   <= not reqreg;
		--end if;
    end if;
  end process sync;

  data <= data_tgl & std_logic_vector(data_cnt); --concatenation of vectors
  --req  <= reqreg;

 end architecture src_arch;