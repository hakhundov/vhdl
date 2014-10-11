------------------------------------------
--TEST BENCH CPU.vhd---------------
------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity test_cpu is
  -- no ports  
end test_cpu;

architecture first_test of test_cpu is

COMPONENT CPU
      PORT ( 
			clk : in bit;
			InStructions : in bit_vector(15 DOWNTO 0)
			);
END COMPONENT ;

SIGNAL clk: bit;
SIGNAL InStructions : bit_vector(15 downto 0);

begin
A : CPU
  PORT MAP (
  clk => clk,
  InStructions=>InStructions
  );


InStructions   <= "0010"&"0000"&"1111"&"0000",
                  "0010"&"0001"&"1111"&"0001" after 10 ns,
                  "0010"&"0010"&"1111"&"0010" after 20 ns,
                  "0010"&"0011"&"1111"&"0011" after 30 ns,
                  "0010"&"0100"&"1111"&"0100" after 40 ns,
                  "0010"&"0101"&"1111"&"0101" after 50 ns,
                  "0010"&"0110"&"1111"&"0110" after 60 ns,
                  "0010"&"0111"&"1111"&"0111" after 70 ns,
                  "0010"&"1000"&"1111"&"1000" after 80 ns,
                  "0010"&"1001"&"1111"&"1001" after 90 ns,
                  "0010"&"1010"&"1111"&"1010" after 100 ns,
                  "0010"&"1011"&"1111"&"1011" after 110 ns,
                  "0010"&"1100"&"1111"&"1100" after 120 ns,
                  "0010"&"1101"&"1111"&"1101" after 130 ns,
                  "0010"&"1110"&"1111"&"1110" after 140 ns,
                  "0010"&"1111"&"1111"&"1111" after 150 ns,
                  --Load registers
                  "0001"&"0010"&"0010"&"0000" after 170 ns,  --Load from memory 0010 to reg 0010
                  "0001"&"1100"&"1100"&"0000" after 180 ns,  --Load from memory 1100 to reg 1100
                  --Add stuff
                  "1000"&"1111"&"0010"&"1100" after 190 ns,  --Add Reg 1100 and 0010 together and store uin 1111
                  --Store register
                  "0100"&"1111"&"1111"&"0000" after 200 ns;  --Store reg 1111 in mem 1111


clock : PROCESS is
   begin
     clk <= '0', '1' after 5ns;
   wait for 10 ns;
end PROCESS clock;

end first_test;