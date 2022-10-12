entity FullAdder is
    port (a, b, cin : in bit;
          s, cout : out bit);
end entity;

architecture equazioni of FullAdder is
begin
    s <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);
end architecture;


-- Addizionatore a 4 bit con ripple carry
entity Adder4 is
    port (a, b : in bit_vector(3 downto 0);
          cin : in bit;
          s : out bit_vector(3 downto 0);
          cout : out bit);
end entity;

architecture strutturale of Adder4 is
    signal c : bit_vector(3 downto 1);
begin
    fa0: entity work.FullAdder port map (a(0), b(0), cin, s(0), c(1));
    fa1: entity work.FullAdder port map (a(1), b(1), c(1), s(1), c(2));
    fa2: entity work.FullAdder port map (a(2), b(2), c(2), s(2), c(3));
    fa3: entity work.FullAdder port map (a(3), b(3), c(3), s(3), cout);
end architecture;
