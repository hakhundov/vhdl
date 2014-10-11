-- Assignment 1, 8x8 Adder
library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
PORT ( A, B, clk : in bit_vector(7 DOWNTO 0);
	   Sum: out bit_vector(7 DOWNTO 0));
end ALU;

architecture only of ALU is
--------------The to_integer function of love ----------------------
function to_integer(inVec : bit_vector)
			return integer is
variable back : integer := 0;
begin 

	for i in 7 DOWNTO 0 LOOP 
		if (inVec(i) = '1') then
			back := back + 2**i;
		end if;
	END LOOP;
	return back;
end to_integer; 

function to_bitVector(inInt : integer)
			return bit_vector is
variable back : bit_vector(7 downto 0) := "00000000";
variable Temp : integer := inInt; 
begin
	for i in 7 DOWNTO 0 LOOP
		if (Temp mod 2 = 1) then
			back(i) := '1';
		else 
			back(i) := '0';
		end if ;
		Temp := Temp / 2;
	End LOOP;
	return back;
end to_bitVector;
--------------------------------------------------------------------

Signal tempA1, tempA2, sum1, sum2  : integer := 0;
Signal A1, Aout : bit_vector(7 downto 0) := "00001111";
Signal A2 : bit_vector(7 downto 0) := "10000001";	
--signal Shity: bit_vector(7 downto 0) := "00001111";
begin
tempA1 <= to_integer(A1);
tempA2 <= to_integer(A2);
sum1 <= to_integer(A1) + to_integer(A2);
Aout <= to_bitVector(sum1);

end only;