library ieee;
use ieee.std_logic_1164.all;

entity d_ff_v is
   generic
  (
    SIZE_VECTOR : integer := 1 --range 2 to integer'high
  );
  port
  (
	clk, res_n,en : in std_logic;
	d : in std_logic_vector(SIZE_VECTOR downto 1);
   q : out std_logic_vector(SIZE_VECTOR downto 1)
  );
end entity d_ff_v;

architecture beh of d_ff_v is
  attribute KEEP : string;
  attribute KEEP of q : signal is "TRUE";
begin
  process(clk, res_n)
  begin
    if res_n = '0' then --Button pressed
      q <= (others =>'0');
    elsif rising_edge(clk) then
		if (en = '1') then
			q <= d;
		end if;
    end if;
  end process;
end architecture beh;
