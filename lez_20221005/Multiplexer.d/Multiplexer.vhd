entity Multiplexer is
    port (a, b, s : in bit; y : out bit);
end entity;

architecture eqz of Multiplexer is
    signal d, e, c : bit;
begin
    d <= a and s after 2 ns;
    e <= not s after 2 ns;
    c <= b and e after 2 ns;
    y <= d or c after 2 ns;
end architecture;
