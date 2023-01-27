library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fade_control_testbench is
--  Port ( );
end fade_control_testbench;

architecture Behavioral of fade_control_testbench is

  constant pwm_bit : integer := 7;
  constant clk_T : time := 10 ns;

  signal clk, res : std_logic;
  signal fade_type : std_logic;
  signal fade_intensity : std_logic_vector( pwm_bit - 1 downto 0 );

begin

  uut : entity work.fade_control generic map ( pwm_bit => pwm_bit )
    port map (
      clk => clk,
      res => res,
      fade_type => fade_type,
      fade_intensity => fade_intensity
    );

  process begin
    clk <= '1'; wait for clk_T/2;
    clk <= '0'; wait for clk_T/2;
  end process;

  process begin
    res <= '0'; wait for 100 ns;
    res <= '1'; wait;
  end process;

  test_proc : process begin
    fade_type <= '0'; wait for 400 us;
    fade_type <= '1'; wait for 400 us;
    wait;
  end process;

end Behavioral;