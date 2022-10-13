library ieee;
use ieee.std_logic_1164.all;

entity encoder is
    port ( A : in std_logic_vector(2 downto 0);
           E : out std_logic_vector(2 downto 0));
end entity;

architecture expression of encoder is
begin
    E(2) <= A(1) and not A(2);
    E(1) <= A(0) and not A(1);
    E(0) <= A(0) xor A(1) xor A(2);
end architecture;
