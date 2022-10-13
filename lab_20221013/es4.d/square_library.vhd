library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity square is
    generic (
        size: integer := 8
    );
    port (
        a: in signed(size - 1 downto 0);
        s: out signed((size * 2) - 1 downto 0)
     );
end entity;

architecture behavioral of square is
begin
    s <= a * a;
end architecture;
