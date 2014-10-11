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


SIGNAL  Opcode, Field1, Field2, Field3 : bit_vector( 3 downto 0 );
SIGNAL Data1, Data2 : bit_vector (7 downto 9);

-- STORAGE -- 16 entries of 8 bits
subtype cell is bit_vector(7 downto 0);
type mem_array is array (0 to 15) of cell;
-- meme = On-chip Memory reg = Registers
signal mem, reg : mem_array;



	
begin

Stage1 : process (clk)

begin
	Opcode <= InStructions(15 downto 12);
	Field1 <= InStructions(11 downto 8);
	Field2 <= InStructions(7 downto 4);
	Field3 <= InStructions(3 downto 0);
end process; -- end of first stage

Stage2 : process (clk)
begin
if (clk = '1') then 
	CASE Opcode is
	-- Load Register
	when "0001" =>  
		reg(to_integer(Field1,4)) <= mem(to_integer(Field2,4));
	
	-- Store Immediate
	when "0010" =>  
		Data1(3 downto 0) <= Field3;
		Data1(7 downto 4) <= Field2;
		mem(to_integer(Field1,4)) <= Data1;

	-- Store Register
	when "0100" =>  
		mem(to_integer(Field2,4)) <= reg(to_integer(Field1,4));
	
	-- ADD
	when "1000" => 
		Data1 <= reg(to_integer(Field2,4));
		Data2 <= reg(to_integer(Field3,4));
		reg(to_integer(Field1)) <= to_bitVector(to_integer(Data1,8) + to_integer(Data2,8),8);

	when others =>
	
	end case;
end if;-- end of rising edge
end process; --end of second stage


end only;