entity Test is
end entity;

architecture simple of Test is
    signal a, b, s, y : bit;
begin
    m1: entity work.Multiplexer port map (a => a, b => b, s => s, y => y);

    a <= '1';
    b <= '1';
    s <= '1', '0' after 100 ns, '1' after 200 ns;
end architecture;
