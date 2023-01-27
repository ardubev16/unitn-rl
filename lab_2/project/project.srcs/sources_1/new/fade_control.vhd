library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fade_control is
  generic (
    pwm_bit  : integer  --numero di bit per i livelli di intensita'
  );
  port (
    clk            : in  std_logic;
    res            : in  std_logic;
    -- Selettore del tipo di effetto: 0 = sawtooth fade, 1 = triangular fade
    fade_type      : in  std_logic;
    -- Uscita del valore di intensita' (da collegare al generatore di PWM)
    fade_intensity : out std_logic_vector( pwm_bit - 1 downto 0 )
  );
end fade_control;

architecture Behavioral of fade_control is

  -- Definire segnali per
  --   tramite un contatore abilitare le operazioni del fade control solo ogni 7.8125 ms
  signal clk_counter : unsigned( 19 downto 0 );
  signal clk_enable  : std_logic;

  --   creare due effetti di modulazione
       -- sawtooth fade : modulazione a dente di sega (loop intensity: 0->max)
       -- triangular fade : modulazione triangolare (loop intensity:  0->max->0) 
  signal current_intensity : unsigned( pwm_bit - 1 downto 0 );
  signal triangular_direction : std_logic;
  
  -- Se si implementa una macchina a stati per controllare il generatore,
  -- definire il tipo per gli stati ed il segnale di stato
  
begin

  -- Si usa un contatore per attivare un segnale ogni 7.8125 ms. Definire qui il
  -- processo che controlla il contatore e genera il segnale
  fade_enable_gen : process( clk, res ) begin
    if res = '0' then
      clk_counter <= (others => '0');
      clk_enable <= '0';
    elsif rising_edge( clk ) then
      -- if clk_counter < 781250 then
      if clk_counter < 128 then
        clk_counter <= clk_counter + 1;
        clk_enable <= '0';
      else
        clk_counter <= (others => '0');
        clk_enable <= '1';
      end if;
    end if;
  end process;

  -- Definire un processo che generi il pattern desiderato, sulla base
  -- dell'ingresso fade_type. Qui potrebbe essere utile avere uno stato per
  -- sapere se si sta generando la forma a sawtooth, oppure se si e' nella fase
  -- ascendente della forma d'onda triangolare, o in quella discendente.
  -- L'intensita' generata da questo modulo potrebbe essere per esempio
  -- memorizzata in un contatore che possa contare in avanti e all'indietro.
  fade_gen : process( clk, res ) begin
      if res = '0' then
          current_intensity <= (others => '0');
          triangular_direction <= '0';
      elsif rising_edge( clk ) then
          if clk_enable = '1' then
              if fade_type = '0' then
          -- sawtooth fade
                  if current_intensity < 2**pwm_bit - 1 then
                      current_intensity <= current_intensity + 1;
                  else
                      current_intensity <= (others => '0');
                  end if;
              else
            -- triangular fade
                  if triangular_direction = '0' then
              -- ascending
                      if current_intensity < 2**pwm_bit - 1 then
                          current_intensity <= current_intensity + 1;
                      else
                          current_intensity <= current_intensity - 1;
                          triangular_direction <= '1';
                      end if;
                  else
              -- descending
                      if current_intensity > 0 then
                          current_intensity <= current_intensity - 1;
                      else
                          current_intensity <= current_intensity + 1;
                          triangular_direction <= '0';
                      end if;
                  end if;
              end if;
          end if;
        end if;
      end process;

      fade_intensity <= std_logic_vector( current_intensity );
end Behavioral;
