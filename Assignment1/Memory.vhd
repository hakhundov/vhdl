---------------------------------------------------
-- LAB Assignment 1 -- On-chip Memory
---------------------------------------------------
-- 16 entries of 8 bits
---------------------------------------------------
-- Inputs:  Address, Write Data, MemWrite, clk
-- Outputs: Read data
---------------------------------------------------
-- Authors:
-- Haji Akhundov, Saevar Hilmarsson
---------------------------------------------------

---NOTES--
---function to_integer() --- must placed in one lcoation


entity memory is
port (  clk: in bit;
	MemWrite: in  bit;
	address : in  bit_vector(3 downto 0);
	write_data: in bit_vector(7 downto 0);
	read_data: out bit_vector(7 downto 0)
);
end entity memory;

architecture basic of memory is

-------------------------------------------------
function to_integer(inVec : bit_vector(3 downto 0))
			return integer is
variable back : integer := 0;
begin 

	for i in 3 DOWNTO 0 LOOP 
		if (inVec(i) = '1') then
			back := back + 2**i;
		end if;
	END LOOP;
	return back;

end to_integer;
--------------------------------------------------

----should the array be initialised?
subtype cell is bit_vector(7 downto 0);
type mem_array is array (0 to 15) of cell;
signal m : mem_array;

begin

output: process (clk )
begin
if (clk'event and clk = '1') then  -- Work on rising edges
  if (MemWrite = '0') then -- READING THE DATA
	read_data <= m(to_integer(address));
  else  		   -- WRITING DATA
	m(to_integer(address)) <= write_data;
  end if;
end if;
end process output;
end architecture basic;