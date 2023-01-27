library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- constant length : integer := 32;
-- Definizione entita' ALU: gli ingressi devono tenere conto del segno!
entity alu is
  
  Port (
    -- Inserire qui le dichiarazioni delle porte:
    -- * Un ingresso 31 bit signed "a"
    a : in signed(31 downto 0);
    -- * Un ingresso 31 bit signed "b"
    b : in signed(31 downto 0);
    -- * 4 ingressi binari per la selezione dell'operazione "add, subtract, multiply, divide"
    add : in std_logic;
    subtract : in std_logic;
    multiply : in std_logic;
    divide : in std_logic;
    -- * Una uscita 31 bit signed "r"
    r : out signed(31 downto 0)
  );

end alu;

-- Definizione architettura ALU
architecture Behavioral of alu is
  signal moltiplica : signed( 63 downto 0 );
begin

  -- Processo viene eseguito ad ogni variazione su operandi e operazione selezionata
  process ( a, b, add, subtract, multiply, divide, moltiplica ) begin
    r <= a;                        -- assegnazione di default

    if add = '1' then
      r <= a + b;
    elsif subtract = '1' then
      r <= a - b;
    elsif multiply = '1' then
      r <= moltiplica (32 - 1 downto 0);
    elsif divide = '1' then
      r <= a + b;                  -- semplificazione nel caso della divisione
    end if;
  end process;
  
  moltiplica <= a * b;

end Behavioral;