----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 11:55:01 AM
-- Design Name: 
-- Module Name: adder4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder4 is
    port (a, b : in std_logic_vector(3 downto 0);
          cin : in std_logic;
          s : out std_logic_vector(3 downto 0);
          cout : out std_logic);
end adder4;

architecture Behavioral of adder4 is
    signal c : std_logic_vector(3 downto 1);
begin
    FA0: entity work.full_adder port map (a(0), b(0), cin, s(0), c(1));
    FA1: entity work.full_adder port map (a(1), b(1), c(1), s(1), c(2));
    FA2: entity work.full_adder port map (a(2), b(2), c(2), s(2), c(3));
    FA3: entity work.full_adder port map (a(3), b(3), c(3), s(3), cout);
end Behavioral;
