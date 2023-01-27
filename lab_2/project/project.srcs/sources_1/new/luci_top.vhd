library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity luci_top is
  port (
    clk             : in  std_logic;
    res             : in  std_logic;
    leftButton      : in  std_logic;
    rightButton     : in  std_logic;
    manual_select   : in  std_logic;
    fadeSelect      : in  std_logic;
    led             : out std_logic;
    --7 segments dispaly I/Os
    CA, CB, CC, CD, CE, CF, CG, DP : out std_logic;
    AN : out std_logic_vector( 7 downto 0 )
  );
end luci_top;

architecture Behavioral of luci_top is

  signal left_button_click   : std_logic;
  signal right_button_click  : std_logic;
  signal led_intensity : std_logic_vector( 6 downto 0 );
  signal led_actual_intensity : std_logic_vector( 6 downto 0 );
  signal display_data : std_logic_vector( 31 downto 0 );

signal led_intensity_sig : std_logic_vector(6 downto 0) := (others => '0');

begin

  --change led intensity (when manual mode is selected). Manual mode can be selected with SW1
  left_button_inst : entity work.button port map (
    clock     => clk,
    reset     => res,
    bouncy    => leftButton,
    pulse     => left_button_click
  );

  right_button_inst : entity work.button port map (
    clock     => clk,
    reset     => res,
    bouncy    => rightButton,
    pulse     => right_button_click
  );

  led_pwm_inst : entity work.led_pwm generic map (
    pwm_bit => 7 
  ) port map (
    clk              => clk,
    res              => res,
    dimmer_up        => left_button_click,
    dimmer_down      => right_button_click,
    intensity_ext    => led_intensity,
    manual_select    => manual_select,
    actualIntensity  => led_actual_intensity,
    led_pwr          => led
  );

  fade_control_inst : entity work.fade_control generic map (
    pwm_bit => 7
  ) port map (
    clk            => clk,
    res            => res,
    fade_type      => fadeSelect,
    fade_intensity => led_intensity
  );    

  -- Instantiate the seven segment display driver
  display_data <= "0000000000000000" & "000000000" & led_actual_intensity;
  thedriver : entity work.seven_segment_driver( Behavioral ) generic map ( size => 21 ) port map (
    clock => clk,
    reset => '1',
    digit0 => display_data( 3 downto 0 ),
    digit1 => display_data( 7 downto 4 ),
    digit2 => display_data( 11 downto 8 ),
    digit3 => display_data( 15 downto 12 ),
    digit4 => display_data( 19 downto 16 ),
    digit5 => display_data( 23 downto 20 ),
    digit6 => display_data( 27 downto 24 ),
    digit7 => display_data( 31 downto 28 ),
    CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, DP => DP,
    AN => AN
  );

end Behavioral;