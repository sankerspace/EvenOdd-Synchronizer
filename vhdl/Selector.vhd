LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;  

entity Selector is
	generic( 
		B_ph : integer range 1 to 50 := 10;  	-- number of nominal bits frequency and phase - overflow bit added additional
		T_to : integer range 1 to 50 := 16; 	--number of bits COUNTER
		X_ph : integer range 1 to 100 := 20; 	-- KEEP OUT REGION IN PERCENT
		K_ph : integer range 1 to 100 := 50 	--  PHASE BOUND IN PERCENT
  );
	port (--input
		clk   :in std_logic;
		res_n :in std_logic;
		evenm :in std_logic;											--phase detector
		tctr  :in std_logic;  										--frequency estimator
		deto  :in std_logic;											--phase detector
		dete  :in std_logic;											--phase detector
		pl		:in std_logic_vector(B_ph downto 0);--B+1 bits	--phase estimator
		pu		:in std_logic_vector(B_ph downto 0);--B+1 bits	--phase estimator
		  --output
		st		:out std_logic;										--frequency estimator
		sel	:out std_logic --even sel=0, odd sel=1
	);
end entity; 


architecture Selector_behave of Selector is
constant V : std_logic_vector(B_ph downto 0) := ( B_ph => '1', others => '0');												-----TEST????????????
constant k : integer:= (to_integer(unsigned(  V  )) * K_ph ) /100;--512 --Phase Bound in Tracking Mode "T"				-----TEST????????????
constant x : integer:= (to_integer(unsigned(  V  )) * X_ph )/100;--205 --Keep Out region- Tracking Mode "T"				-----TEST????????????
TYPE State_type IS (R, FA, PA, P, T);  -- Define the states
SIGNAL State : State_Type;    -- Create a signal that uses 
--variable start_frequencyM:boolean := false;
signal det,reset_counter,timeout : std_logic := '0';
signal count :std_logic_vector(T_to downto 1);
signal enable_counter: std_logic := '1';
signal detection : std_logic := '0';
begin
	
	-- STATE MACHINE------
	FSM : process(clk, res_n)
	begin
		if(res_n = '0') then
			State<=R;
			detection<='0';
		elsif rising_edge(clk) then
		--https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
			case State is
				when R =>	--Reset
					st <= '1'; 
					State<=FA;
					detection<='0';
					enable_counter <= '1';
				when FA=> 	--Frequency Estimate
					st <= '0';
					--phase detection tracked in synchronized proces, but detected combinational
					if (detection = '1' and tctr = '1') then
						State<=PA;
						reset_counter<='1';
						detection <= '0';
					elsif (detection = '0' and tctr = '1') then
						State<=P;
						detection <= '0';
					end if;
				when PA=>	--Phase Acquisition
					if (reset_counter = '1')then
						reset_counter <= '0';
					elsif (timeout = '1') then
						State<=P;
						enable_counter <= '0';
						detection<='0';
					elsif(detection = '1') then
						State<=T;
						enable_counter <= '0';
					end if;
				when P=>		--Plesiochronous
					if (detection = '1') then
						State<=T;
					end if;
					sel <= evenm; 
				when T=>		--Tracking
					if ((unsigned(pu)-unsigned(pl)) > to_unsigned(k,B_ph+1)) then
						State<=P;
						detection <= '0';
					end if;
					if (to_integer(unsigned(pl)) >= x) and ( to_integer(unsigned(pl)) <= (x + to_integer(unsigned(V))) ) then --?????????????????PASST DA SO??
						sel <= '0';--select even
					else
						sel<= '1';--select odd
					end if;
			
			end case;
			
			if(det = '1') then
				detection <= '1'; --sychronized phased detection event
			end if;
		
			
		end if;
	end process FSM;

	
	COUNTER:entity work.counter
	generic map
	(
		LEN => T_to
		
	)
	port map(
		count => count,
		clk => clk,
		en => enable_counter,
		overflow => timeout,
		sync_reset=>reset_counter,
		res_button => res_n
	);
	
	--COMBINATIONAL LOGIC
	det <= dete or deto;



	
end architecture Selector_behave;
