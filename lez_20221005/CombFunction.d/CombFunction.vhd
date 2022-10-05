entity CombFunction is
    port (a, b, c : in bit; z : out bit);
end entity CombFunction;

architecture expression of CombFunction is
    signal d : bit;
begin
    z <= d or c after 4 ns;
    d <= a and b after 5 ns;
end architecture expression;
