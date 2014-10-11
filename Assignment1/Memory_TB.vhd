------------------------------------------
--TEST BENCH FOR Memory.vhd---------------
------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity test_mem is
  -- no ports  
end test_mem;

architecture first_test of test_mem is

COMPONENT memory
      PORT ( 	clk: in bit;
		MemWrite: in  bit;
		address : in  bit_vector(3 downto 0);
		write_data: in bit_vector(7 downto 0);
		read_data: out bit_vector(7 downto 0)
);
END COMPONENT ;

--FOR MEM: memory use entity work.memory;

SIGNAL clk, MemWrite : bit;
SIGNAL address : bit_vector(3 downto 0);
SIGNAL write_data, read_data : bit_vector(7 downto 0);

begin
MEM : memory
  PORT MAP (
  clk => clk,
  MemWrite => MemWrite,
  address => address,
  write_data => write_data,
  read_data => read_data );


MemWrite   <= '1', '0' after 19 ns;
address    <= "0000", "0001" after 4 ns , "0010" after 9 ns, "0011" after 14 ns, "0100" after 19 ns, "0001" after 24 ns , "0010" after 29 ns, "0011" after 34 ns, "0100" after 39 ns;
write_data <= "00000000", "11111111" after 4 ns , "11110000" after 9 ns, "10101010" after 14 ns, "00001111" after 19 ns;

clock : PROCESS is
   begin
     clk <= '0', '1' after 5ns;
   wait for 10 ns;
end PROCESS clock;

end first_test;