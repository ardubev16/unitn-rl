library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture behavioral of testbench is
    signal a: signed(7 downto 0);
    signal s8: signed(15 downto 0);

    signal a4: signed(3 downto 0);
    signal s4: signed(7 downto 0);
begin
    add32: entity work.square
        port map(
            a => a,
            s => s8
        );

    add8: entity work.square
        generic map(size => 4)
        port map(
            a => a4,
            s => s4
        );

    process begin
        -- to_signed( value, size )
        a <= to_signed(0, 8);
        wait for 10 ns;
        a <= to_signed(35, 8);
        wait for 10 ns;
        a <= to_signed(18, 8);
        wait for 10 ns;
        a <= to_signed(- 18, 8);
        wait for 10 ns;
        a <= to_signed(120, 8);
        wait for 10 ns;
        a <= to_signed(- 120, 8);
        wait for 10 ns;
        wait;
    end process;
end architecture;
