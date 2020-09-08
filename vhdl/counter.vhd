LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity counter is
	generic
  (
    LEN : integer range 1 to 50 := 10  --range 2 to integer'high;
	 -- upper bound of the counter
  );
	port (
		count : buffer std_logic_vector(LEN downto 1);
		overflow: out std_logic;
		clk   : in std_logic;
		en		:in std_logic;
		sync_reset : in std_logic;
		res_button : in std_logic
		);
end;

architecture only of counter is
	constant tpd_reset_to_count : time := 3 ns;
	constant tpd_clk_to_count   : time := 2 ns;
	constant tpd_reset   		 : time := 2 ns;
	constant bound					 : std_logic_vector(LEN downto 1) := (LEN=>'1',others=>'0');
	function increment(val : std_logic_vector) return std_logic_vector
	is
		-- normalize the indexing
		alias input : std_logic_vector(val'length downto 1) is val;
		variable result : std_logic_vector(input'range) := input;
		variable carry : std_logic := '1';
	begin
		for i in input'low to input'high loop
			result(i) := input(i) xor carry;
			carry := input(i) and carry;
			exit when carry = '0';
		end loop;
		return result;
	end increment;
begin

	ctr:
	process(clk, res_button)
	begin
		if (res_button = '0') then
			count <= (others => '0') after tpd_reset_to_count;
			overflow <= '0' after tpd_reset;
		elsif clk'event and (clk = '1') then
			if (en = '1') then
				if (sync_reset = '1') then
					count <= (others => '0') after tpd_reset_to_count;
					overflow <= '0' after tpd_reset;
				else
					count <= increment(count) after tpd_clk_to_count;
					if(count = bound) then
						overflow <= '1' after tpd_reset;
					end if;
				end if;
			end if;
		end if;
	end process;

end only;


