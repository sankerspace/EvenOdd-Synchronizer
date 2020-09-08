library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
  port
  (
    clk, res_n, d, en : in std_logic;
    q : out std_logic
  );
end entity d_ff;

architecture beh of d_ff is
  attribute KEEP : string;
  attribute KEEP of q : signal is "TRUE";
begin
  process(clk, res_n)
  begin
    if res_n = '0' then --Button pressed
      q <= '0';
    elsif rising_edge(clk) then
		if (en = '1')then
			q <= d;
		end if;
    end if;
  end process;
end architecture beh;
