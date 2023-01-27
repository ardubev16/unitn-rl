entity Test_And2 is
end entity Test_And2;

architecture simple of Test_And2 is
    signal a, b, c : bit;
begin
    g1: entity work.And2 port map (x => a, y => b, z => c);

    a <= '0', '1' after 100 ns, '0' after 200 ns;
    b <= '0', '1' after 150 ns, '0' after 250 ns;
end architecture simple;
