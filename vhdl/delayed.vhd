LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


ENTITY delay_line IS
PORT ( 
		a : IN std_logic;
		b : OUT std_logic
		);
END ENTITY delay_line;


ARCHITECTURE behave OF delay_line IS
attribute KEEP : boolean;

signal v1,v2,v3,v4,v5,v6,v7,v8,v9 , v10,v11,v12,v13,v14,v15,v16,v17,v18,v19 : std_logic;

attribute KEEP of v1 : signal is true;
attribute KEEP of v2 : signal is true;
attribute KEEP of v3 : signal is true;
attribute KEEP of v4 : signal is true;
attribute KEEP of v5 : signal is true;
attribute KEEP of v6 : signal is true;
attribute KEEP of v7 : signal is true;
attribute KEEP of v8 : signal is true;
attribute KEEP of v9 : signal is true;

attribute KEEP of v10 : signal is true;
attribute KEEP of v11 : signal is true;
attribute KEEP of v12 : signal is true;
attribute KEEP of v13 : signal is true;
attribute KEEP of v14 : signal is true;
attribute KEEP of v15 : signal is true;
attribute KEEP of v16 : signal is true;
attribute KEEP of v17 : signal is true;
attribute KEEP of v18 : signal is true;
attribute KEEP of v19 : signal is true;
BEGIN
--per not Gate estimated ~300 ps  delay
-- delay with 20 not Gates -> 6ns
v1 <= not a after 300ps;  v2<= not v1 after 300ps;
v3<= not v2 after 300ps; v4 <= not v3 after 300ps;
v5<= not v4 after 300ps; v6 <= not v5 after 300ps;
v7<= not v6 after 300ps; v8 <= not v7 after 300ps;
v9<= not v8 after 300ps; v10 <= not v9 after 300ps;
v11<= not v10 after 300ps; v12 <= not v11 after 300ps;
v13<= not v12 after 300ps; v14 <= not v13 after 300ps;
v15<= not v14 after 300ps; v16 <= not v15 after 300ps;
v17<= not v16 after 300ps; v18 <= not v17 after 300ps;
v19 <= not v18 after 300ps;b<= not v19 after 300ps; 

END ARCHITECTURE behave;
