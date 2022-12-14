library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity calcolatrice is
  Port (
    -- Inserire qui le dichiarazioni delle porte:
    -- * Un ingresso clock
    -- * Un ingresso reset
    -- * Un ingresso per gli switch "SW" - 8 bit
    -- * Una uscita per i led "LED" - 8 bit
    -- * Ingressi per i bottoni "BTNC, BTNU, BTNL, BTNR, BTND"
    
    --OLED I/Os
    oled_sdin    : out std_logic;
    oled_sclk    : out std_logic;
    oled_dc      : out std_logic;
    oled_res     : out std_logic;
    oled_vbat    : out std_logic;
    oled_vdd     : out std_logic;
    oledPoweroff : in  std_logic
  );
end calcolatrice;

architecture Behavioral of calcolatrice is
  -- Segnali interni per i debouncer
  signal center_edge, up_edge, left_edge, right_edge, down_edge : std_logic;
  -- Segnali di ingresso/uscita per accumulatore
  signal acc_in, acc_out : signed( 31 downto 0 );
  -- Segnali di init e load per accumulatore
  signal acc_init, acc_enable : std_logic;
  -- Segnali di controllo per ALU
  signal do_add, do_sub, do_mult, do_div : std_logic;
  -- L'uscita dell'accumulatore va convertiva in std_logic_vector
  signal display_value : std_logic_vector( 31 downto 0 );
  -- Segnali per gli switch di ingresso
  signal sw_input : std_logic_vector( 31 downto 0 );
 
begin

  
  -- Dichiarazione Bottoni:
  center_detect : entity work.debouncer(Behavioral)
  port map (
    clock   => clock,
    reset   => reset,
    bouncy  => BTNC,
    pulse   => center_edge
  );
  
  up_detect : entity work.debouncer(Behavioral)
  port map (
    -- collega il bottone
  );
  
  down_detect : entity work.debouncer(Behavioral)
  port map (
    -- collega il bottone come display shutdown
  );
  
  left_detect : entity work.debouncer(Behavioral)
  port map (
    -- collega il bottone
  );

  right_detect : entity work.debouncer(Behavioral)
  port map (
    -- collega il bottone
  );

  -- Instantiate the OLED display driver
  OLED_display : entity work.oled_driver(Behavioral)
  port map(
        clock      => clock,
        reset      => '1',
        poweroff   => oledPoweroff,
        display_in => display_value,
        oled_sdin  => oled_sdin,
        oled_sclk  => oled_sclk,
        oled_dc    => oled_dc,
        oled_res   => oled_res,
        oled_vbat  => oled_vbat,
        oled_vdd   => oled_vdd    
  );

  LED <= SW;
  
  -- Sign extended switches
  sw_input <= SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) &
              SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) &
              SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW(7) & SW;
              
  -- Instantiate the ALU
  the_alu : entity work.alu( Behavioral ) 
  port map(
  -- Collega la alu all'accumulatore e agli switch. Collega inoltre i segnali interni per stabilire l'operazione
    
  );
  -- Assegna ai segnali interni l'uscita dei corrispettivi debouncer
  do_add  <= up_edge;
  do_sub  <= ...
  do_mult <= ...

  -- Instantiate the accumulator
  the_accumulator : entity work.accumulator( Behavioral ) port map (
  -- Collega l'accumulatore
  );
   
    -- Assegna a display value il valore d'uscita
  display_value <= std_logic_vector( ... );
   -- Assegna acc_enable e acc_init come da consegna
  acc_enable <= ...
  acc_init <= ...;
  
end Behavioral;
