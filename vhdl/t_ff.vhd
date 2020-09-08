library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity T_FF is
port( 
	T: in std_logic;
	Reset: in std_logic;
	Clock: in std_logic;
	En	  : in std_logic; 
	Q: out std_logic);
end T_FF;
 
architecture Behavioral of T_FF is
--signal tmp: std_logic :='0';
begin
process (Clock)
begin
if Reset = '0' then
	Q <= '0';
elsif rising_edge(Clock) then 
	if (En='1')then
		Q <= not T;
	end if;
end if;
end process;
end Behavioral;
