entity Test_CombFunction is
end entity Test_CombFunction;

architecture simple of Test_CombFunction is
    signal a, b, c, z : bit;
begin
    g1: entity work.CombFunction port map (a => a, b => b, c => c, z => z);

    a <= '0', '1' after 100 ns, '0' after 200 ns, '0' after 300 ns;
    b <= '0', '1' after 150 ns, '0' after 250 ns, '0' after 300 ns;
    c <= '1', '0' after 100 ns;
end architecture simple;
