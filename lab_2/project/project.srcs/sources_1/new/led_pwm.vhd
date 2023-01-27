library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_pwm is
  generic (
    -- Numero di bit del contatore del PWM
    pwm_bit : integer := 7
  );
  port (
    clk              : in  std_logic;
    res              : in  std_logic;
    -- Ingressi per controllare la luminosita'
    dimmer_up        : in  std_logic;
    dimmer_down      : in  std_logic;
    -- Ingresso di valore di intensita' esterno, da collegare al generatore di
    -- pattern (il fade_control)
    intensity_ext    : in  std_logic_vector( pwm_bit - 1 downto 0 );
    -- Ingresso di selezione tra l'uso del fade control oppure l'impostazione
    -- manuale
    manual_select    : in  std_logic;
    -- Uscita per mostrare l'effettivo valore di intensita' impiegato (da
    --- mandare eventualmente ai display)
    actualIntensity  : out std_logic_vector( pwm_bit - 1 downto 0 );
    -- Uscita PWM che controlla il LED
    led_pwr          : out std_logic
  );
end led_pwm;

-- Definizione dell'architettura del modulatore PWM.
architecture Behavioral of led_pwm is

  -- Definire segnali per il PWM, per esempio un contatore, e per tenere traccia
  -- del livello di intensita' da impostare tramite i bottoni.
  signal counter : unsigned( pwm_bit - 1 downto 0 );
  signal soglia  : unsigned( pwm_bit - 1 downto 0 );

begin

  -- Definire un processor che implementi un contatore free running
  pwm_counter: process( clk, res ) begin
    if res = '0' then
      counter <= (others => '0');
    elsif rising_edge( clk ) then
      counter <= counter + 1;
    end if;
  end process;

  -- Definire un processor che aggiorni il valore dell'uscita led_pwr a seconda
  -- dei valori del contatore e della intensita' desiderata
  pwm_control: process( clk ) begin
    if rising_edge( clk ) then
      if counter < soglia then
        led_pwr <= '1';
      else
        led_pwr <= '0';
        end if;
    end if;
  end process;

  -- Definire un processo che sulla base dei bottoni di comando aggiorni il
  -- valore dell'intensita' desiderata
  intensity_control: process( clk ) begin
    if rising_edge( clk ) then
      if manual_select = '0' then
        if dimmer_up = '1' then
          soglia <= soglia + 1;
        elsif dimmer_down = '1' then
          soglia <= soglia - 1;
        end if;
      else
        soglia <= unsigned( intensity_ext );
      end if;
    end if;
  end process;

  -- Definire processi o equazioni per selezionare il livello di intensita'
  -- desiderata tra quella in ingresso dall'esterno oppure quella impostata dai
  -- bottoni. Definire anche il valore dell'intensita' effettiva che viene
  -- utilizzata da mandare al segnale actualIntensity
  -- intensity_level: process( clk ) begin
  --   if rising_edge( clk ) then
  --     if manual_select = '1' then
  --       actualIntensity <= std_logic_vector(soglia);
  --     else
  --       actualIntensity <= intensity_ext;
  --     end if;
  --   end if;
  -- end process;

  actualIntensity <= std_logic_vector(soglia);
end Behavioral;
