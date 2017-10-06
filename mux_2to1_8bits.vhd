library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1_8bits is
    Port ( S : in  STD_LOGIC;
           S0   : in  STD_LOGIC_VECTOR (7 downto 0);
           S1   : in  STD_LOGIC_VECTOR (7 downto 0);
           D    : out STD_LOGIC_VECTOR (7 downto 0));
end mux_2to1_8bits;

architecture mux_2to1_8bits of mux_2to1_8bits is
begin
    D <= S0 when (S = '0') else S1;
end mux_2to1_8bits;