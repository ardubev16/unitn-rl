library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
  generic (
    counter_size : integer := 12
  );
  port (
    clock : in std_logic;
    reset : in std_logic;
    bouncy : in std_logic;
    pulse : out std_logic
  );
end debouncer;

architecture behavioral of debouncer is
  -- Definizione dei segnali interni :
  -- * counter: tiene traccia dell'intervallo temporale /home/ardubev_16in cui il segnale e' stabile
  -- * candidate_value: tiene traccia del valore stabile candidato
  -- * stable_value: tiene traccia del valore stabile attuale 
  -- * delayed_stable_value: versione ritardata di stable value per generare l'uscita
  signal counter : unsigned(counter_size - 1 downto 0);
  signal candidate_value : std_logic := '0';
  signal stable_value : std_logic := '0';
  signal delayed_stable_value : std_logic := '0';
begin

  process ( clock, reset ) begin
    if reset = '0' then
      -- reset contatore, stable e canditate value
      counter <= (others => '0');
      stable_value <= '0';
      candidate_value <= '0';
    elsif rising_edge( clock ) then
      -- Controlla se il segnale e' stabile
      if bouncy = candidate_value then
        -- Segnale stabile. Controlla per quanto tempo
        if counter = 0 then
          -- Aggiorna il valore stabile
          stable_value <= candidate_value;
        else
          -- Decrementa il contatore
          counter <= counter - 1;
        end if;
      else
        -- Segnale non stabile. Aggiorna il valore candidato e resetta il contatore
        candidate_value <= bouncy;
        counter <= (others => '1');
      end if;
    end if;
  end process;

  -- Processo che crea una versione ritardata del segnale stable (delayed_stable_value)
  process ( clock, reset ) begin
    if reset = '0' then
      -- Assegnazione valore di reset
      delayed_stable_value <= '0';
    elsif rising_edge( clock ) then
      -- Assegnazione valore ad ogni ciclo di clock
      delayed_stable_value <= stable_value;
    end if;
  end process;

  -- Genera impulso d'uscita
  pulse <= '1' when stable_value = '1' and delayed_stable_value = '0' else
           '0';

end behavioral;
