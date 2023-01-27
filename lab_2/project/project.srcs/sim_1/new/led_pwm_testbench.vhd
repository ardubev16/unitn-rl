----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2020 06:20:42 PM
-- Design Name: 
-- Module Name: led_pwm_testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_pwm_testbench is
--  Port ( );
end led_pwm_testbench;

architecture Behavioral of led_pwm_testbench is

    constant pwm_bit : integer := 7;
    constant clk_T : time := 10 ns;

    signal clk, res : std_logic;
    signal dimmer_up, dimmer_down : std_logic;
    signal intensity_ext : std_logic_vector( pwm_bit - 1 downto 0 );
    signal manual_select : std_logic;
    signal actualIntensity : std_logic_vector( pwm_bit - 1 downto 0 );
    signal led_pwr : std_logic := '0';

  begin

    uut : entity work.led_pwm generic map ( pwm_bit => pwm_bit )
      port map (
        clk => clk,
        res => res,
        dimmer_up => dimmer_up,
        dimmer_down => dimmer_down,
        intensity_ext => intensity_ext,
        manual_select => manual_select,
        actualIntensity => actualIntensity,
        led_pwr => led_pwr
      );

    --generate clock 
    process begin
      clk <= '0'; wait for clk_T / 2;
      clk <= '1'; wait for clk_T / 2;
    end process;

    process begin
      res <= '0'; wait for 100 ns;
      res <= '1'; wait;
    end process;

    testProc : process begin
      dimmer_up <= '0';
      dimmer_down <= '0';
      intensity_ext <= "0000000";
      manual_select <= '1';
      wait for 100 ns;

      intensity_ext <= "0111111"; --intensity = half range (50% led intensity);
      wait for 10 us;

      intensity_ext <= "1111111"; --intensity = full range (100% led intensity);
      wait for 10 us;

      intensity_ext <= "0000010"; --intensity = almost min range (approx 0% led intensity);
      wait for 10 us;

      manual_select <= '0';
      for i in 0 to 127 loop
        dimmer_up <= '1';
        wait for 10 ns;
        dimmer_up <= '0';
        wait for 5 us;
      end loop;
      wait;
    end process;

end Behavioral;
