----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 11:58:09 AM
-- Design Name: 
-- Module Name: testAdder4 - Behavioral
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

entity testAdder4 is
--  Port ( );
end testAdder4;

architecture Behavioral of testAdder4 is
    component adder4 is
        port (a, b : in std_logic_vector(3 downto 0);
          cin : in std_logic;
          s : out std_logic_vector(3 downto 0);
          cout : out std_logic);
    end component;
    signal a, b, s : std_logic_vector(3 downto 0);
    signal cin, cout : std_logic;
begin
    -- Device under test
    dut: adder4 port map(a, b, cin, s, cout);
    -- Definizione stimoli
    a <= "0000", "0010" after 100 ns, "1110" after 200ns, "0110" after 300 ns;
    b <= "0000", "1010" after 50 ns, "0011" after 150 ns, "1100" after 250 ns;
    cin <= '0', '1' after 125 ns, '0' after 175 ns, '1' after 275 ns;

end Behavioral;
