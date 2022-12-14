library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
  generic (
    counter_size : integer := 12
  );
  port (
    -- Inserire qui le dichiarazioni delle porte:
    -- * Un ingresso di clock "clock"
    -- * Un ingresso di reset "reset"
    -- * Un ingresso per il bottone "bouncy"
    -- * Una uscita per l'impulse "pulse"
  );
end debouncer;

architecture behavioral of debouncer is

  -- Definizione dei segnali interni :
  -- * counter: tiene traccia dell'intervallo temporale in cui il segnale e' stabile
  -- * candidate_value: tiene traccia del valore stabile candidato
  -- * stable_value: tiene traccia del valore stabile attuale 
  -- * delayed_stable_value: versione ritardata di stable value per generare l'uscita

begin

  process ( clock, reset ) begin
    if reset = '0' then
      -- reset contatore, stable e canditate value
    elsif rising_edge( clock ) then
      -- Controlla se il segnale e' stabile
      if bouncy = candidate_value then
        -- Segnale stabile. Controlla per quanto tempo
        if counter = 0 then
          -- Aggiorna il valore stabile
          
        else
          -- Decrementa il contatore
          
        end if;
      else
        -- Segnale non stabile. Aggiorna il valore candidato e resetta il contatore
        
      end if;
    end if;
  end process;

  -- Processo che crea una versione ritardata del segnale stable (delayed_stable_value)
  process ( clock, reset ) begin
    if reset = '0' then
      -- Assegnazione valore di reset
    elsif rising_edge( clock ) then
      -- Assegnazione valore ad ogni ciclo di clock
    end if;
  end process;

  -- Genera impulso d'uscita
  pulse <= '1' when stable_value = ... and delayed_stable_value = ... else
           '0';

end behavioral;

