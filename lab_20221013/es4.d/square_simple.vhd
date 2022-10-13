entity square is
    port (input : in bit_vector(2 downto 0);
         output : out bit_vector(5 downto 0));
end entity;

architecture expression of square is
begin
    output(5) <= '0';
    output(4) <= input(0) and not input(1) and not input(2);
    output(3) <= input(2) and (input(0) xor input(1));
    output(2) <= input(1) and not input(2);
    output(1) <= '0';
    output(0) <= input(2);
end architecture;
