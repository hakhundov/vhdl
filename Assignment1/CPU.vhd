-- Assignment 1
library IEEE;

entity CPU is
PORT ( clk : in bit;
	   InStructions : in bit_vector(15 DOWNTO 0));
end CPU;

architecture only of CPU is

--------------The to_integer function for x bits ----------------------
function to_integer(inVec : bit_vector; x : integer)
			return integer is
variable back : integer := 0;
begin 

	for i in (x - 1) DOWNTO 0 LOOP 
		if (inVec(i) = '1') then
			back := back + 2**i;
		end if;
	END LOOP;
	return back;
end to_integer; 

--------------The to_bitVector function for x bits --------------------
function to_bitVector(inInt, x : integer)
			return bit_vector is
variable back : bit_vector(7 downto 0) := "00000000";
variable Temp : integer := inInt; 
begin
	for i in 0 TO (x - 1) LOOP
		if (Temp mod 2 = 1) then
			back(i) := '1';
		else 
			back(i) := '0';
		end if ;
		Temp := Temp / 2;
	End LOOP;
	return back;
end to_bitVector;

begin
Stage1 : process is
begin
	if (InStructions(12) = '1') then
		--Load register
	elsif (InStructions(13) = '1') then
		--Store Immediate
	elsif (InStructions(14) = '1') then
		--Store Register
	elsif (InStructions(15) = '1') then
		--Add stuff
	else 
		--Do nothing
	end if;
end process;
end only;